// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:shoppinglist/03_domain/entities/item.dart';
import 'package:shoppinglist/03_domain/repositories/item_repository.dart';
import 'package:shoppinglist/core/failures/item_failures.dart';

class ItemUsecases {
  final ItemRepository itemRepository;

  ItemUsecases({
    required this.itemRepository,
  });

  Future<Either<ItemFailure, Unit>> create(String listId, Item item) {
    return itemRepository.create(listId, item);
  }

  Future<Either<ItemFailure, Unit>> delete(String listId, Item item) {
    return itemRepository.delete(listId, item.id.value);
  }

  Future<Either<ItemFailure, Unit>> itemBought(String listId, Item item) async {
    await itemRepository.createBought(listId, item);
    return itemRepository.delete(listId, item.id.value);
  }

  Future<Either<ItemFailure, Unit>> update(String listId, Item item) {
    return itemRepository.update(listId, item);
  }

  Stream<Either<ItemFailure, List<Item>>> watchAll(String listId) {
    return itemRepository.watchAll(listId);
  }
}
