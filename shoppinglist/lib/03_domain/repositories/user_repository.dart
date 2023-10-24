import 'package:dartz/dartz.dart';
import 'package:shoppinglist/03_domain/entities/user_data.dart';
import 'package:shoppinglist/core/failures/user_failures.dart';

abstract class UserRepository {
  Future<Either<UserFailure, Unit>> create(UserData user);

  //todo might be useless
  Stream<Either<UserFailure, UserData>> watch();

  Future<Either<UserFailure, Unit>> update(UserData user);

  Future<Either<UserFailure, Unit>> deleteDocument();

  Future<Either<UserFailure, UserData>> getById(String id);

  Future<Either<UserFailure, List<UserData>>> getByName(String id);

  Future<Either<UserFailure, UserData>> getCurrentUserData();

  Future<Either<UserFailure, Unit>> purgeUserConnections();
}
