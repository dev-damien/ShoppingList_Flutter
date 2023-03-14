import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shoppinglist/core/failures/user_failure.dart';

abstract class UserRepository {
  //todo might be useless
  Stream<Either<UserFailure, List<User>>> watchAll();

  Future<Either<UserFailure, Unit>> update(User user);

  //todo or use UniqueID only
  //todo maybe remove entirely
  Future<Either<UserFailure, Unit>> delete(User user);
}
