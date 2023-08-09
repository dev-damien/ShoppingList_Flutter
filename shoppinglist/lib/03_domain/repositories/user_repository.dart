import 'package:dartz/dartz.dart';
import 'package:shoppinglist/03_domain/entities/user_data.dart';
import 'package:shoppinglist/core/failures/user_failures.dart';

abstract class UserRepository {
  Future<Either<UserFailure, Unit>> create(UserData user);

  //todo might be useless
  Stream<Either<UserFailure, UserData>> watch();

  Future<Either<UserFailure, Unit>> update(UserData user);

  //todo or use UniqueID only
  //todo maybe remove entirely
  Future<Either<UserFailure, Unit>> delete(UserData user);
}
