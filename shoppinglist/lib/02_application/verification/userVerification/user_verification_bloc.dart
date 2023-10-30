import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shoppinglist/03_domain/usecases/auth_usecases.dart';
import 'package:shoppinglist/core/failures/user_failures.dart';

part 'user_verification_event.dart';
part 'user_verification_state.dart';

class UserVerificationBloc
    extends Bloc<UserVerificationEvent, UserVerificationState> {
  final AuthUsecases authUsecases;

  UserVerificationBloc({required this.authUsecases})
      : super(UserVerificationInitial()) {
    on<sendVerificationMail>(
      (event, emit) async {
        emit(UserVerificationInProgress());
        try {
          await authUsecases.sendVerificationMail();
          await Future.delayed(const Duration(seconds: 2));
          emit(UserVerificationSuccess());
        } catch (e) {
          emit(UserVerificationFailure(userFailure: UnexpectedFailure()));
        }
      },
    );
  }
}
