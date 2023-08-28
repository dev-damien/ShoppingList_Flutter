// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';

import 'package:shoppinglist/03_domain/entities/list.dart';
import 'package:shoppinglist/03_domain/repositories/auth_repository.dart';
import 'package:shoppinglist/03_domain/repositories/list_repository.dart';
import 'package:shoppinglist/04_infrastructure/models/list_model.dart';
import 'package:shoppinglist/core/errors/errors.dart';
import 'package:shoppinglist/core/failures/list_failures.dart';
import 'package:shoppinglist/injection.dart';

class ListRepositoryImpl implements ListRepository {
  final FirebaseFirestore firestore;

  ListRepositoryImpl({
    required this.firestore,
  });

  @override
  Future<Either<ListFailure, Unit>> create(ListData list) {
    // TODO: implement create
    throw UnimplementedError();
  }

  @override
  Future<Either<ListFailure, Unit>> delete(ListData list) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<Either<ListFailure, Unit>> update(ListData list) {
    // TODO: implement update
    throw UnimplementedError();
  }

  @override
  Stream<Either<ListFailure, ListData>> watch(String listId) async* {
    try {
      print("list repo -> watch($listId)");
      final listDoc = firestore.collection('lists').doc(listId);
      final Stream<DocumentSnapshot<Map<String, dynamic>>> querySnapshots =
          listDoc.snapshots();

      yield* querySnapshots.map((doc) {
        if (!doc.exists) return left<ListFailure, ListData>(ListDoesNotExist());
        var listData = ListModel.fromFirestore(doc).toDomain();
        return right<ListFailure, ListData>(listData);
      }).handleError((e) async* {
        // Handle different error case
        if (e is FirebaseException) {
          if (e.code.contains("permission-denied") ||
              e.code.contains("PERMISSION_DENIED")) {
            yield left<ListFailure, ListData>(InsufficientPermissions());
          } else {
            yield left<ListFailure, ListData>(UnexpectedFailureFirebase());
          }
        } else {
          yield left<ListFailure, ListData>(UnexpectedFailure());
        }
      });
    } catch (e) {}
  }
}
