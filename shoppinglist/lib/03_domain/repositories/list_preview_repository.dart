import 'package:dartz/dartz.dart';
import 'package:shoppinglist/core/failures/list_preview_failures.dart';
import 'package:shoppinglist/03_domain/entities/list_preview.dart';

abstract class ListPreviewRepository {
  Stream<Either<ListPreviewFailure, List<ListPreview>>> watchAll();

  Future<Either<ListPreviewFailure, Unit>> create(
    String userId,
    ListPreview list,
  );

  Future<Either<ListPreviewFailure, Unit>> update(
    String userId,
    ListPreview list,
  );

  Future<Either<ListPreviewFailure, Unit>> delete(
    String userId,
    String listId,
  ); //todo or use UniqueID only
}
