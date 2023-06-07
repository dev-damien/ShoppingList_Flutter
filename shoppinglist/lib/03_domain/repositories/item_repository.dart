import 'package:dartz/dartz.dart';
import 'package:shoppinglist/core/failures/item_failures.dart';
import 'package:shoppinglist/03_domain/entities/item.dart';

//TODO rethink methods
abstract class ItemRepository {
  Stream<Either<ItemFailure, List<Item>>> watchAll();

  Future<Either<ItemFailure, Unit>> create(Item item);

  Future<Either<ItemFailure, Unit>> update(Item item);

  Future<Either<ItemFailure, Unit>> delete(
      Item item); //todo or use UniqueID only
}
