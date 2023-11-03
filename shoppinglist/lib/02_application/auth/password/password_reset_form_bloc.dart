import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shoppinglist/03_domain/usecases/auth_usecases.dart';
import 'package:shoppinglist/core/failures/reset_password_failures.dart';

part 'password_reset_form_event.dart';
part 'password_reset_form_state.dart';

class PasswordResetFormBloc
    extends Bloc<PasswordResetFormEvent, PasswordResetFormState> {
  final AuthUsecases authUsecases;

  PasswordResetFormBloc({required this.authUsecases})
      : super(PasswordResetFormInitial()) {
    on<SendPasswordResetMailEvent>((event, emit) async {
      await authUsecases.sendResetPasswordMail();
      await Future.delayed(const Duration(seconds: 1)); // fake waiting
      emit(PasswordResetFormMailSent());
    });
    on<ResetPasswordEvent>(
      (event, emit) async {
        emit(PasswordResetFormInProgress());
        final failureOrSuccess =
            await authUsecases.resetPassword(event.code, event.newPassword);
        failureOrSuccess.fold(
          (failure) {
            emit(PasswordResetFormFailure(resetPasswordFailure: failure));
          },
          (success) {
            emit(PasswordResetFormSuccess());
          },
        );
      },
    );
  }
}
