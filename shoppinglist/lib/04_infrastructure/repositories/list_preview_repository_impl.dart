import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:shoppinglist/core/failures/list_preview_failures.dart';
import 'package:shoppinglist/03_domain/entities/list_preview.dart';
import 'package:shoppinglist/03_domain/repositories/list_preview_repository.dart';
import 'package:shoppinglist/04_infrastructure/extensions/firebase_helpers.dart';
import 'package:shoppinglist/04_infrastructure/models/list_preview_model.dart';

class ListPreviewRepositoryImpl implements ListPreviewRepository {
  final FirebaseFirestore firestore;

  ListPreviewRepositoryImpl({required this.firestore});

  @override
  Future<Either<ListPreviewFailure, Unit>> create(
      String userId, ListPreview listPreview) async {
    try {
      final userDoc = firestore.collection('users').doc(userId);
      final listPreviewModel = ListPreviewModel.fromDomain(listPreview);

      await userDoc
          .collection('lists_preview')
          .doc(listPreviewModel.id)
          .set(listPreviewModel.toMap());

      return right(unit);
    } on FirebaseException catch (e) {
      if (e.code.contains("PERMISSION_DENIED")) {
        return left(InsufficientPermissions());
      } else {
        return left(UnexpectedFailure());
      }
    }
  }

  @override
  Future<Either<ListPreviewFailure, Unit>> delete(
      String userId, ListPreview list) async {
    try {
      final userDoc = firestore.collection('users').doc(userId);
      final listPreviewModel = ListPreviewModel.fromDomain(list);

      await userDoc.listPreviewCollection.doc(listPreviewModel.id).delete();

      return right(unit);
    } on FirebaseException catch (e) {
      if (e.code.contains("PERMISSION_DENIED")) {
        // NOT_FOUND
        return left(InsufficientPermissions());
      } else {
        return left(UnexpectedFailure());
      }
    }
  }

  @override
  Future<Either<ListPreviewFailure, Unit>> update(
      String userId, ListPreview listPreview) async {
    try {
      final userDoc = firestore.collection('users').doc(userId);
      final listPreviewModel = ListPreviewModel.fromDomain(listPreview);

      await userDoc.listPreviewCollection
          .doc(listPreviewModel.id)
          .update(listPreviewModel.toMap());

      return right(unit);
    } on FirebaseException catch (e) {
      if (e.code.contains("PERMISSION_DENIED")) {
        // NOT_FOUND
        return left(InsufficientPermissions());
      } else {
        return left(UnexpectedFailure());
      }
    }
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
