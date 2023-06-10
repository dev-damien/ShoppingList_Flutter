import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:shoppinglist/03_domain/usecases/auth_usecases.dart';
import 'package:shoppinglist/core/failures/auth_failures.dart';

part 'sign_up_form_event.dart';
part 'sign_up_form_state.dart';

class SignUpFormBloc extends Bloc<SignUpFormEvent, SignUpFormState> {
  final AuthUsecases authUsecases;
  SignUpFormBloc({required this.authUsecases})
      : super(SignUpFormState(
            isSubmitting: false,
            showValidationMessages: false,
            authFailureOrSuccessOption: none())) {
    on<RegisterWithEmailAndPasswordPressed>((event, emit) async {
      if (event.email == null || event.password == null) {
        emit(state.copyWith(isSubmitting: false, showValidationMessages: true));
      } else {
        emit(state.copyWith(isSubmitting: true, showValidationMessages: false));
        final failureOrSuccess =
            await authUsecases.registerWithEmailAndPassword(
                email: event.email!, password: event.password!);
        emit(state.copyWith(
            isSubmitting: false,
            authFailureOrSuccessOption: optionOf(failureOrSuccess)));
      }
    });

    on<SignInWithEmailAndPasswordPressed>(
      (event, emit) async {
        if (event.email == null || event.password == null) {
          emit(state.copyWith(
              isSubmitting: false, showValidationMessages: true));
        } else {
          emit(state.copyWith(
              isSubmitting: true, showValidationMessages: false));
          final failureOrSuccess =
              await authUsecases.signInWithEmailAndPassword(
                  email: event.email!, password: event.password!);
          emit(state.copyWith(
              isSubmitting: false,
              authFailureOrSuccessOption: optionOf(failureOrSuccess)));
        }
      },
    );
  }
}
