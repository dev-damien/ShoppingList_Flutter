import 'package:dartz/dartz.dart';
import 'package:shoppinglist/core/failures/list_preview_failures.dart';
import 'package:shoppinglist/03_domain/entities/list_preview.dart';

abstract class ListPreviewRepository {
  Stream<Either<ListPreviewFailure, List<ListPreview>>> watchAll();

  Future<Either<ListPreviewFailure, Unit>> create(
    ListPreview list,
  );

  Future<Either<ListPreviewFailure, Unit>> update(
    ListPreview list,
  );

  Future<Either<ListPreviewFailure, Unit>> delete(
    ListPreview list,
  ); //todo or use UniqueID only
}
