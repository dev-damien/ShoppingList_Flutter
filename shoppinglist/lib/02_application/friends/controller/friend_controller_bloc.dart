import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:shoppinglist/03_domain/entities/friend.dart';
import 'package:shoppinglist/03_domain/usecases/friend_usecases.dart';
import 'package:shoppinglist/core/failures/friend_failures.dart';

part 'friend_controller_event.dart';
part 'friend_controller_state.dart';

class FriendControllerBloc
    extends Bloc<FriendControllerEvent, FriendControllerState> {
  final FriendUsecases friendUsecases;

  FriendControllerBloc({required this.friendUsecases})
      : super(FriendControllerInitial()) {
    on<UpdateFriendNicknameEvent>((event, emit) async {
      emit(
        FriendControllerInProgress(
          friend: event.friend,
        ),
      );
      //? only for visual purpose. can be removed
      await Future.delayed(const Duration(seconds: 2));

      final failureOrSuccess = await friendUsecases
          .updateNickname(event.friend.copyWith(nickname: event.nickname));
      failureOrSuccess.fold(
          (failure) => emit(FriendControllerFailure(
              friend: event.friend, friendFailure: failure)),
          (r) => emit(FriendControllerSuccess(friend: event.friend)));
    });
    on<RemoveFriendEvent>((event, emit) async {
      emit(FriendControllerInProgress(friend: event.friend));
      //? only for visual purpose. can be removed
      await Future.delayed(const Duration(seconds: 2));

      final failureOrSuccess = await friendUsecases.unfriendUser(event.friend);
      failureOrSuccess.fold(
          (failure) => emit(FriendControllerFailure(
              friendFailure: failure, friend: event.friend)),
          (r) => emit(FriendControllerSuccess(friend: event.friend)));
    });
  }
}
