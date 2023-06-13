import 'package:dartz/dartz.dart';
import 'package:shoppinglist/03_domain/entities/list_preview.dart';
import 'package:shoppinglist/03_domain/repositories/list_preview_repository.dart';
import 'package:shoppinglist/core/failures/list_preview_failures.dart';

class ListPreviewUsecases {
  final ListPreviewRepository listPreviewRepository;

  ListPreviewUsecases({required this.listPreviewRepository});

  Stream<Either<ListPreviewFailure, List<ListPreview>>> watchAll() {
    return listPreviewRepository.watchAll();
  }

  Future<Either<ListPreviewFailure, Unit>> create(ListPreview list) {
    return listPreviewRepository.create(list);
  }

  Future<Either<ListPreviewFailure, Unit>> update(ListPreview list) {
    return listPreviewRepository.update(list);
  }

  Future<Either<ListPreviewFailure, Unit>> delete(ListPreview list) {
    return listPreviewRepository.delete(list);
  }
}
