import 'dart:core';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:shoppinglist/03_domain/entities/friend.dart';
import 'package:shoppinglist/03_domain/entities/list.dart';
import 'package:shoppinglist/03_domain/repositories/auth_repository.dart';
import 'package:shoppinglist/03_domain/usecases/list_usecases.dart';
import 'package:shoppinglist/03_domain/usecases/user_usecases.dart';
import 'package:shoppinglist/constants/default_values.dart';
import 'package:shoppinglist/core/errors/errors.dart';
import 'package:shoppinglist/core/failures/list_failures.dart';
import 'package:shoppinglist/injection.dart';

part 'list_form_event.dart';
part 'list_form_state.dart';

class ListFormBloc extends Bloc<ListFormEvent, ListFormState> {
  final ListUsecases listUsecases;
  final UserUsecases userUsecases;

  ListFormBloc({required this.listUsecases, required this.userUsecases})
      : super(ListFormState.initial()) {
    on<InitializeListEditPage>((event, emit) async {
      final friends = event.friends ?? [];
      if (event.listData != null) {
        final notFriendMembersIds = event.listData!.members
            .where(
                (member) => !(friends.map((e) => e.id.value)).contains(member))
            .toList();
        final List<Friend> notFriendMembersData = [];
        notFriendMembersIds.map(
          (id) async => await userUsecases.getUserById(id)
            ..fold(
              (failure) {},
              (userData) {
                notFriendMembersData.add(Friend(
                  id: userData.id,
                  nickname: userData.name,
                  imageId: userData.imageId,
                ));
              },
            ),
        );
        final friendMembersIds = event.listData!.members
            .where(
                (member) => (friends.map((e) => e.id.value)).contains(member))
            .toList();
        final friendMembersData = friendMembersIds
            .map(
              (friendId) => event.friends!
                  .where((friend) => friend.id.value == friendId)
                  .toList()
                  .first,
            )
            .toList();

        final allMembersData = notFriendMembersData + friendMembersData;

        emit(
          state.copyWith(
            listData: event.listData,
            isEditing: true,
            members: allMembersData,
          ),
        );
      } else {
        emit(
          ListFormState.initial().copyWith(
            listData: ListData.empty()
                .copyWith(imageId: DefaultValues.defaultListIconId),
          ),
        );
      }
    });
    on<ToggleIsFavoriteEvent>((event, emit) {
      emit(state.copyWith(isFavorite: !state.isFavorite));
    });
    on<DataChangedEvent>((event, emit) {
      ListData editedListData = state.listData;
      if (event.title != null) {
        editedListData = editedListData.copyWith(title: event.title);
      }
      if (event.imageId != null) {
        editedListData = editedListData.copyWith(imageId: event.imageId);
      }
      emit(state.copyWith(listData: editedListData));
    });
    on<AddMemberEvent>((event, emit) {
      final editedMembersIds = state.listData.members..add(event.user.id.value);
      final editedMembers = state.members..add(event.user);

      emit(state.copyWith(
        listData: state.listData.copyWith(members: editedMembersIds),
        members: editedMembers,
      ));
    });
    on<RemoveMemberEvent>((event, emit) {
      final editedMembersIds = state.listData.members
        ..remove(event.user.id.value);
      final editedMembers = state.members..remove(event.user);

      emit(state.copyWith(
        listData: state.listData.copyWith(members: editedMembersIds),
        members: editedMembers,
      ));
    });
    on<SafePressedEvent>((event, emit) async {
      Either<ListFailure, Unit>? failureOrSuccess;

      if (state.listData.title.isEmpty) {
        emit(state.copyWith(
            showErrorMessages: true,
            failureOrSuccessOption: optionOf(left(NoValueForTitleProvided()))));
      } else {
        emit(state.copyWith(isSaving: true, failureOrSuccessOption: none()));

        final userOption = sl<AuthRepository>().getSignedInUser();
        final user = userOption.getOrElse(() => throw NotAuthenticatedError());

        final members = state.listData.members;
        final admins = state.listData.admins;

        if (!state.isEditing) {
          // if creating, add creator as member and admin
          members.add(user.id.value);
          admins.add(user.id.value);
        }

        ListData editedList = state.listData.copyWith(
          title: event.title,
          imageId: event.imageId,
          members: state.listData.members,
          admins: admins,
        );

        if (state.isEditing) {
          failureOrSuccess =
              await listUsecases.update(editedList, state.isFavorite);
        } else {
          failureOrSuccess =
              await listUsecases.create(editedList, state.isFavorite);
        }

        emit(state.copyWith(
          isSaving: false,
          showErrorMessages: true,
          failureOrSuccessOption: optionOf(failureOrSuccess),
          listData:
              null, // reset listdata for correct behaviour in the initialize method at next call
        ));
      }
    });
  }
}
