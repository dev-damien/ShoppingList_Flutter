import 'package:dartz/dartz.dart';
import 'package:shoppinglist/core/failures/auth_failures.dart';
import 'package:shoppinglist/03_domain/entities/user.dart';


abstract class AuthRepository {
  Future<Either<AuthFailure, Unit>> registerWithEmailAndPassword(
      {required String email, required String password});

  Future<Either<AuthFailure, Unit>> signInWithEmailAndPassword(
      {required String email, required String password});

  Future<void> signOut();

  Option<CustomUser> getSignedInUser();

  Future<void> deleteAccount();

  Future<bool> isEmailAuthenticated();

}
