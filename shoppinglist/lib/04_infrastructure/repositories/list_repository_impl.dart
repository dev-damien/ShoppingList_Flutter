// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:shoppinglist/03_domain/entities/item.dart';

import 'package:shoppinglist/03_domain/entities/list.dart';
import 'package:shoppinglist/03_domain/repositories/list_repository.dart';
import 'package:shoppinglist/04_infrastructure/models/item_model.dart';
import 'package:shoppinglist/04_infrastructure/models/list_model.dart';
import 'package:shoppinglist/core/failures/list_failures.dart';

class ListRepositoryImpl implements ListRepository {
  final FirebaseFirestore firestore;

  ListRepositoryImpl({
    required this.firestore,
  });

  @override
  Future<Either<ListFailure, Unit>> create(ListData list) async {
    try {
      final listModel = ListModel.fromDomain(list);

      await firestore
          .collection('lists')
          .doc(listModel.id)
          .set(listModel.toMap());

      return right(unit);
    } on FirebaseException catch (e) {
      if (e.code.contains("PERMISSION_DENIED")) {
        return left(InsufficientPermissions());
      } else {
        return left(UnexpectedFailure());
      }
    }
  }

  // TODO maybe check for admin rights before deleting list
  @override
  Future<Either<ListFailure, Unit>> delete(String listId) async {
    try {
      //final userDoc = await firestore.userDocument();
      final listDoc = await firestore.collection('lists').doc(listId).get();

      //* remove list previews for all members
      for (String memberId in listDoc.get('members')!) {
        await firestore
            .collection('users')
            .doc(memberId)
            .collection('lists_preview')
            .doc(listId)
            .delete();
      }

      //* remove main list entry in lists collection
      await firestore.collection('lists').doc(listId).delete();

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
  Future<Either<ListFailure, Unit>> update(ListData list) async {
    try {
      final listModel = ListModel.fromDomain(list);

      await firestore
          .collection('lists')
          .doc(listModel.id)
          .update(listModel.toMap());

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

  @override
  Future<Either<ListFailure, ListData>> get(String listId) async {
    try {
      print("list repo -> get($listId)");
      final listDoc = await firestore.collection('lists').doc(listId).get();

      if (!listDoc.exists) {
        return left<ListFailure, ListData>(ListDoesNotExist());
      }
      var listData = ListModel.fromFirestore(listDoc).toDomain();
      return right<ListFailure, ListData>(listData);
    } catch (e) {
      if (e is FirebaseException) {
        if (e.code.contains("permission-denied") ||
            e.code.contains("PERMISSION_DENIED")) {
          return left<ListFailure, ListData>(InsufficientPermissions());
        } else {
          return left<ListFailure, ListData>(UnexpectedFailureFirebase());
        }
      } else {
        return left<ListFailure, ListData>(UnexpectedFailure());
      }
    }
  }

  @override
  Future<Either<ListFailure, List<Item>>> getItems(String listId) async {
    try {
      print("list repo -> getItems($listId)");
      return await firestore
          .collection('lists')
          .doc(listId)
          .collection('items')
          .get()
          .then((snapshot) => right(snapshot.docs.map((doc) {
                return ItemModel.fromFirestore(doc).toDomain();
              }).toList()));
    } catch (e) {
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
    }
  }

  @override
  Future<Either<ListFailure, List<Item>>> getItemsBought(String listId) async {
    try {
      print("list repo -> getItemsBought($listId)");
      return await firestore
          .collection('lists')
          .doc(listId)
          .collection('items_bought')
          .get()
          .then((snapshot) => right(snapshot.docs.map((doc) {
                return ItemModel.fromFirestore(doc).toDomain();
              }).toList()));
    } catch (e) {
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
    }
  }
}
