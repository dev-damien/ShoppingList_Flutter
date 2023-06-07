import 'package:dartz/dartz.dart';
import 'package:shoppinglist/core/failures/item_failures.dart';
import 'package:shoppinglist/03_domain/entities/item.dart';
import 'package:shoppinglist/03_domain/repositories/item_repository.dart';

class ItemRepositoryImpl implements ItemRepository {
  @override
  Future<Either<ItemFailure, Unit>> create(Item item) {
    // TODO: implement create
    throw UnimplementedError();
  }

  @override
  Future<Either<ItemFailure, Unit>> delete(Item item) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<Either<ItemFailure, Unit>> update(Item item) {
    // TODO: implement update
    throw UnimplementedError();
  }

  @override
  Stream<Either<ItemFailure, List<Item>>> watchAll() {
    // TODO: implement watchAll
    throw UnimplementedError();
  }
}
