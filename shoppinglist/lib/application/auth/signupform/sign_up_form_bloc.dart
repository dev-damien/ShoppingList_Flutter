import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'sign_up_form_event.dart';
part 'sign_up_form_state.dart';

class SignUpFormBloc extends Bloc<SignUpFormEvent, SignUpFormState> {
  SignUpFormBloc()
      : super(SignUpFormState(
            isSubmitting: false, showValidationMessages: false)) {
    on<RegisterWithEmailAndPasswordPressed>((event, emit) {
      if (event.email == null || event.password == null) {
        emit(state.copyWith(isSubmitting: false, showValidationMessages: true));
      } else {
        emit(state.copyWith(
            isSubmitting: true,
            showValidationMessages: false)); // TDOD: trigger registration
      }
    });

    on<SignInWithEmailAndPasswordPressed>((event, emit) {
      if (event.email == null || event.password == null) {
        emit(state.copyWith(isSubmitting: false, showValidationMessages: true));
      } else {
        emit(state.copyWith(isSubmitting: true, showValidationMessages: false));
        // TDOD: trigger authentication
      }
    });
  }
}
