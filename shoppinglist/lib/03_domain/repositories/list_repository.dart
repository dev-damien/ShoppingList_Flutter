import 'package:dartz/dartz.dart';
import 'package:shoppinglist/core/failures/list_failures.dart';
import 'package:shoppinglist/03_domain/entities/list.dart';

abstract class ListRepository {
  Stream<Either<ListFailure, ListData>> watch(String listId);

  Future<Either<ListFailure, Unit>> create(ListData list);

  Future<Either<ListFailure, Unit>> update(ListData list);

  Future<Either<ListFailure, Unit>> delete(
      String listId); 
}
