import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shoppinglist/core/failures/auth_failures.dart';
import 'package:shoppinglist/03_domain/entities/user.dart';
import 'package:shoppinglist/core/failures/reset_password_failures.dart';

abstract class AuthRepository {
  Future<Either<AuthFailure, Unit>> registerWithEmailAndPassword(
      {required String email, required String password});

  Future<Either<AuthFailure, Unit>> signInWithEmailAndPassword(
      {required String email, required String password});

  Future<void> signOut();

  Option<CustomUser> getSignedInUser();

  Future<void> deleteAccount();

  Future<void> sendVerificationMail();

  Future<bool> isEmailAuthenticated();

  Future<void> sendResetPasswordMail();

  Future<Either<ResetPasswordFailure, Unit>> resetPassword(
      String code, String newPassword);

  Stream<Either<AuthFailure, User?>> watchAuthState();
}
