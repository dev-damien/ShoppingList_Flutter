// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';

import 'package:shoppinglist/03_domain/entities/item.dart';
import 'package:shoppinglist/03_domain/repositories/auth_repository.dart';
import 'package:shoppinglist/03_domain/repositories/item_repository.dart';
import 'package:shoppinglist/04_infrastructure/models/item_model.dart';
import 'package:shoppinglist/core/errors/errors.dart';
import 'package:shoppinglist/core/failures/item_failures.dart';
import 'package:shoppinglist/injection.dart';

class ItemRepositoryImpl implements ItemRepository {
  final FirebaseFirestore firestore;

  ItemRepositoryImpl({
    required this.firestore,
  });

  @override
  Future<Either<ItemFailure, Unit>> create(String listId, Item item) async {
    try {
      final listDoc = firestore.collection('lists').doc(listId);
      final itemModel = ItemModel.fromDomain(item);

      await listDoc
          .collection('items')
          .doc(itemModel.id)
          .set(itemModel.toMap());

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
  Future<Either<ItemFailure, Unit>> createBought(
      String listId, Item item) async {
    try {
      final listDoc = firestore.collection('lists').doc(listId);
      final itemModel = ItemModel.fromDomain(item);

      // onyl for user id
      final userOption = sl<AuthRepository>().getSignedInUser();
      final user = userOption.getOrElse(() => throw NotAuthenticatedError());

      final additionalInfos = <String, dynamic>{
        'boughtTime': Timestamp.now(),
        'boughtBy': user.id.value,
      };

      await listDoc
          .collection('items_bought')
          .doc(itemModel.id)
          .set(itemModel.toMap()..addEntries(additionalInfos.entries));

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
  Future<Either<ItemFailure, Unit>> delete(String listId, Item item) async {
    try {
      final listDoc = firestore.collection('lists').doc(listId);
      final itemModel = ItemModel.fromDomain(item);

      await listDoc.collection('items').doc(itemModel.id).delete();

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
  Future<Either<ItemFailure, Unit>> update(String listId, Item item) async {
    try {
      final listDoc = firestore.collection('lists').doc(listId);
      final itemModel = ItemModel.fromDomain(item);

      await listDoc
          .collection('items')
          .doc(itemModel.id)
          .update(itemModel.toMap());

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
  Stream<Either<ItemFailure, List<Item>>> watchAll(String listId) async* {
    final listDoc = await firestore.collection('lists').doc(listId);

    yield* listDoc
        .collection('items')
        .snapshots()
        .map((snapshot) =>
            right<ItemFailure, List<Item>>(snapshot.docs.map((doc) {
              return ItemModel.fromFirestore(doc).toDomain();
            }).toList()))
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
