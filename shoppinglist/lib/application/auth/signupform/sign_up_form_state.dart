part of 'sign_up_form_bloc.dart';

class SignUpFormState {
  final bool isSubmitting;
  final bool showValidationMessages;
  final Option<Either<AuthFailure, Unit>> authFailureOrSuccessOption;

  SignUpFormState(
      {required this.isSubmitting,
      required this.showValidationMessages,
      required this.authFailureOrSuccessOption});

  SignUpFormState copyWith({
    bool? isSubmitting,
    bool? showValidationMessages,
    Option<Either<AuthFailure, Unit>>? authFailureOrSuccessOption,
  }) {
    return SignUpFormState(
        isSubmitting: isSubmitting ?? this.isSubmitting,
        authFailureOrSuccessOption:
            authFailureOrSuccessOption ?? this.authFailureOrSuccessOption,
        showValidationMessages:
            showValidationMessages ?? this.showValidationMessages);
  }
}
