import 'package:dartz/dartz.dart';
import 'package:shoppinglist/core/failures/list_failures.dart';
import 'package:shoppinglist/domain/entities/list.dart';

abstract class ListRepository {
  Stream<Either<ListFailure, List<ListData>>> watchAll();

  Future<Either<ListFailure, Unit>> create(ListData list);

  Future<Either<ListFailure, Unit>> update(ListData list);

  Future<Either<ListFailure, Unit>> delete(
      ListData list); //todo or use UniqueID only
}
