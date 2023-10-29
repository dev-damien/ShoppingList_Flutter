import 'package:dartz/dartz.dart';
import 'package:shoppinglist/03_domain/entities/user.dart';
import 'package:shoppinglist/03_domain/repositories/auth_repository.dart';
import 'package:shoppinglist/core/failures/auth_failures.dart';

class AuthUsecases {
  final AuthRepository authRepository;

  AuthUsecases({required this.authRepository});

  Future<Either<AuthFailure, Unit>> registerWithEmailAndPassword(
      {required String email, required String password}) async {
    return authRepository.registerWithEmailAndPassword(
        email: email, password: password);
  }

  Future<Either<AuthFailure, Unit>> signInWithEmailAndPassword(
      {required String email, required String password}) async {
    return authRepository.signInWithEmailAndPassword(
        email: email, password: password);
  }

  Future<void> signOut() async {
    return authRepository.signOut();
  }

  Option<CustomUser> getSignedInUser() {
    return authRepository.getSignedInUser();
  }

  Future<void> deleteAccount() async {
    return authRepository.deleteAccount();
  }

  Future<void> sendVerificationMail() async {
    return authRepository.sendVerificationMail();
  }

  Future<bool> isEmailAuthenticated() async {
    return authRepository.isEmailAuthenticated();
  }
}
