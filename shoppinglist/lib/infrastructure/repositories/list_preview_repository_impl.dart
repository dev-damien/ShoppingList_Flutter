import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:shoppinglist/core/failures/list_preview_failures.dart';
import 'package:shoppinglist/domain/entities/list_preview.dart';
import 'package:shoppinglist/domain/repositories/list_preview_repository.dart';
import 'package:shoppinglist/infrastructure/extensions/firebase_helpers.dart';
import 'package:shoppinglist/infrastructure/models/list_preview_model.dart';

class ListPreviewRepositoryImpl implements ListPreviewRepository {
  final FirebaseFirestore firestore;

  ListPreviewRepositoryImpl({required this.firestore});

  @override
  Future<Either<ListPreviewFailure, Unit>> create(ListPreview list) {
    // TODO: implement create
    throw UnimplementedError();
  }

  @override
  Future<Either<ListPreviewFailure, Unit>> delete(ListPreview list) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<Either<ListPreviewFailure, Unit>> update(ListPreview list) {
    // TODO: implement update
    throw UnimplementedError();
  }

  @override
  Stream<Either<ListPreviewFailure, List<ListPreview>>> watchAll() async* {
    final userDoc = await firestore.userDocument();

    // right side: listen on list_previews
    yield* userDoc.listPreviewCollection
        .snapshots()
        .map((snapshot) => right<ListPreviewFailure, List<ListPreview>>(snapshot
            .docs
            .map((doc) => ListPreviewModel.fromFirestore(doc).toDomain())
            .toList()))
        .handleError((e) {
      //error handling left side
      if (e is FirebaseException) {
        if (e.code.contains("permission-denied") ||
            e.code.contains("PERMISSION_DENIED")) {
          return left(InsufficientPermissions());
        } else {
          return left(UnexpectedFailureFirebase());
        }
      } else {
        return left(UnexpectedFailure());
      }
    });
  }
}
