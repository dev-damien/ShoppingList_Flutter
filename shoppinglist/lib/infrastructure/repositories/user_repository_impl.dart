import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shoppinglist/core/failures/user_failures.dart';
import 'package:shoppinglist/domain/repositories/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  @override
  Future<Either<UserFailure, Unit>> delete(User user) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<Either<UserFailure, Unit>> update(User user) {
    // TODO: implement update
    throw UnimplementedError();
  }

  @override
  Stream<Either<UserFailure, List<User>>> watchAll() {
    // TODO: implement watchAll
    throw UnimplementedError();
  }
}
