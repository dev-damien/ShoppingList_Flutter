import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:shoppinglist/03_domain/entities/item.dart';
import 'package:shoppinglist/03_domain/repositories/auth_repository.dart';
import 'package:shoppinglist/03_domain/usecases/item_usecases.dart';
import 'package:shoppinglist/core/errors/errors.dart';
import 'package:shoppinglist/core/failures/item_failures.dart';
import 'package:shoppinglist/injection.dart';

part 'add_item_form_event.dart';
part 'add_item_form_state.dart';

class AddItemFormBloc extends Bloc<ItemAddFormEvent, AddItemFormState> {
  final ItemUsecases itemUsecases;

  AddItemFormBloc({required this.itemUsecases})
      : super(AddItemFormState.initial()) {
    on<InitializeItemAddFormEvent>((event, emit) {
      emit(AddItemFormState.initial());
    });
    on<SafePressedEvent>((event, emit) async {
      emit(state.copyWith(isSaving: true, failureOrSuccessOption: none()));
      //? only for visual purpose. can be removed
      await Future.delayed(const Duration(milliseconds: 500));

      Either<ItemFailure, Unit>? failureOrSuccess;

      if (event.title == null || event.title!.isEmpty) {
        emit(state.copyWith(
            isSaving: false,
            showErrorMessages: true,
            failureOrSuccessOption: optionOf(left(EmptyTitleNotAllowed()))));
      } else {
        final userOption = sl<AuthRepository>().getSignedInUser();
        final user = userOption.getOrElse(() => throw NotAuthenticatedError());
        final String listId = event.listId;
        final Item item = Item.empty().copyWith(
          title: event.title,
          quantity: event.number ?? 1,
          addedBy: user.id.value,
          addedTime: Timestamp.now(),
        );

        failureOrSuccess = await itemUsecases.create(listId, item);

        emit(state.copyWith(
          isSaving: false,
          showErrorMessages: true,
          failureOrSuccessOption: optionOf(failureOrSuccess),
          isDone: true,
        ));
      }
    });
  }
}
