import 'package:dartz/dartz.dart';
import 'package:shoppinglist/03_domain/entities/list_preview.dart';
import 'package:shoppinglist/03_domain/repositories/list_preview_repository.dart';
import 'package:shoppinglist/core/failures/list_preview_failures.dart';

class ListPreviewUsecases {
  final ListPreviewRepository listPreviewRepository;

  ListPreviewUsecases({
    required this.listPreviewRepository,
  });

  Stream<Either<ListPreviewFailure, List<ListPreview>>> watchAll() {
    return listPreviewRepository.watchAll();
  }

  Future<Either<ListPreviewFailure, Unit>> create(
      String userId, ListPreview list) {
    return listPreviewRepository.create(userId, list);
  }

  Future<Either<ListPreviewFailure, Unit>> update(
      String userId, ListPreview list) {
    return listPreviewRepository.update(userId, list);
  }

  Future<Either<ListPreviewFailure, Unit>> delete(
      String userId, String listId) {
    return listPreviewRepository.delete(userId, listId);
  }
}
