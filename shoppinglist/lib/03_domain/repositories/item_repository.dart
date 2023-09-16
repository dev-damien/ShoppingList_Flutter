import 'package:dartz/dartz.dart';
import 'package:shoppinglist/core/failures/item_failures.dart';
import 'package:shoppinglist/03_domain/entities/item.dart';

//TODO rethink methods
abstract class ItemRepository {
  Stream<Either<ItemFailure, List<Item>>> watchAll(String listId);

  Future<Either<ItemFailure, Unit>> create(String listId, Item item);

  Future<Either<ItemFailure, Unit>> createBought(String listId, Item item);

  Future<Either<ItemFailure, Unit>> update(String listId, Item item);

  Future<Either<ItemFailure, Unit>> delete(String listId, String itemId);
}
