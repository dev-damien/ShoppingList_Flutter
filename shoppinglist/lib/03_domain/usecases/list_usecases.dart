import 'package:dartz/dartz.dart';
import 'package:shoppinglist/03_domain/entities/list.dart';
import 'package:shoppinglist/03_domain/repositories/list_repository.dart';
import 'package:shoppinglist/core/failures/list_failures.dart';

class ListUsecases {
  final ListRepository listRepository;

  ListUsecases({
    required this.listRepository,
  });

  Stream<Either<ListFailure, ListData>> watch(String listId) {
    return listRepository.watch(listId);
  }

  Future<Either<ListFailure, Unit>> create(ListData list) {
    return listRepository.create(list);
  }

  Future<Either<ListFailure, Unit>> update(ListData list) {
    return listRepository.update(list);
  }

  Future<Either<ListFailure, Unit>> delete(ListData list) {
    return listRepository.delete(list);
  }
}
