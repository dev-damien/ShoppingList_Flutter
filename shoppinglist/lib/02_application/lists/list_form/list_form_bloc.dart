import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:shoppinglist/03_domain/entities/friend.dart';
import 'package:shoppinglist/03_domain/entities/list.dart';
import 'package:shoppinglist/03_domain/usecases/list_usecases.dart';
import 'package:shoppinglist/constants/default_values.dart';
import 'package:shoppinglist/core/failures/list_failures.dart';

part 'list_form_event.dart';
part 'list_form_state.dart';

class ListFormBloc extends Bloc<ListFormEvent, ListFormState> {
  final ListUsecases listUsecases;
  ListFormBloc({required this.listUsecases}) : super(ListFormState.initial()) {
    on<InitializeListEditPage>((event, emit) {
      if (event.listData != null) {
        emit(state.copyWith(listData: event.listData, isEditing: true));
      } else {
        print('not nulllllll');
        emit(state.copyWith(
            listData: state.listData
                .copyWith(imageId: DefaultValues.defaultListIconId)));
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
      if (event.members != null) {
        editedListData = editedListData.copyWith(
            members: event.members!.map((e) => e.id.value).toList());
      }
      if (event.imageId != null) {
        editedListData = editedListData.copyWith(imageId: event.imageId);
      }
      emit(state.copyWith(listData: editedListData));
    });
    on<SafePressedEvent>((event, emit) async {
      Either<ListFailure, Unit>? failureOrSuccess;

      emit(state.copyWith(isSaving: true, failureOrSuccessOption: none()));

      if (event.title != null) {
        final ListData editedList =
            state.listData.copyWith(title: event.title, imageId: event.imageId);

        if (state.isEditing) {
          failureOrSuccess =
              await listUsecases.update(editedList, state.isFavorite);
        } else {
          failureOrSuccess =
              await listUsecases.create(editedList, state.isFavorite);
        }
      }

      emit(state.copyWith(
          isSaving: false,
          showErrorMessages: true,
          failureOrSuccessOption: optionOf(failureOrSuccess)));
    });
  }
}
