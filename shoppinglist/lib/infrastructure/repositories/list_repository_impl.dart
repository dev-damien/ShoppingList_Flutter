import 'package:shoppinglist/domain/entities/list.dart';
import 'package:shoppinglist/core/failures/list_failures.dart';
import 'package:dartz/dartz.dart';
import 'package:shoppinglist/domain/repositories/list_repository.dart';

class ListRepositoryImpl implements ListRepository {
  @override
  Future<Either<ListFailure, Unit>> create(ListData list) {
    // TODO: implement create
    throw UnimplementedError();
  }

  @override
  Future<Either<ListFailure, Unit>> delete(ListData list) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<Either<ListFailure, Unit>> update(ListData list) {
    // TODO: implement update
    throw UnimplementedError();
  }

  @override
  Stream<Either<ListFailure, List<ListData>>> watchAll() {
    // TODO: implement watchAll
    throw UnimplementedError();
  }
}
