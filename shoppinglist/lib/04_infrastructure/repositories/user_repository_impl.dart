// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:shoppinglist/03_domain/entities/user_data.dart';

import 'package:shoppinglist/03_domain/repositories/user_repository.dart';
import 'package:shoppinglist/04_infrastructure/extensions/firebase_helpers.dart';
import 'package:shoppinglist/04_infrastructure/models/user_model.dart';
import 'package:shoppinglist/core/failures/user_failures.dart';

class UserRepositoryImpl implements UserRepository {
  final FirebaseFirestore firestore;

  UserRepositoryImpl({
    required this.firestore,
  });

  @override
  Future<Either<UserFailure, Unit>> delete(UserData user) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<Either<UserFailure, Unit>> update(UserData user) {
    // TODO: implement update
    throw UnimplementedError();
  }

  @override
  Stream<Either<UserFailure, UserData>> watch() async* {
    print("userrepo -> watch()"); // TODO remove
    final userDoc = await firestore.userDocument();
    final Stream<DocumentSnapshot<Map<String, dynamic>>> querySnapshots =
        userDoc.snapshots() as Stream<DocumentSnapshot<Map<String, dynamic>>>;

    yield* querySnapshots.map((doc) {
      var res = UserModel.fromFirestore(doc).toDomain();
      return res;
    }).map((userData) {
      return right<UserFailure, UserData>(userData);
    }).handleError((e) {
      // Handle different error cases
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

  @override
  Future<Either<UserFailure, Unit>> create(UserData user) async {
    throw UnimplementedError();

    //   try {
    //     final userDoc = await firestore.userDocument();
    //     final todoModel = UserModel.fromDomain(user);

    //     await userDoc.todoCollection.doc(todoModel.id).set(todoModel.toMap());

    //     return right(unit);
    //   } on FirebaseException catch (e) {
    //     if (e.code.contains("PERMISSION_DENIED")) {
    //       return left(InsufficientPermisssons());
    //     } else {
    //       return left(UnexpectedFailure());
    //     }
    //   }
  }

  @override
  Future<Either<UserFailure, UserData>> getById(String id) async {
    try {
      print("userrepo -> get user by id $id"); // TODO remove
      final userDoc = FirebaseFirestore.instance.collection("users").doc(id);

      final docSnapshot = await userDoc.get();

      if (docSnapshot.exists) {
        // user with id exists
        UserData userData = UserModel.fromFirestore(docSnapshot).toDomain();
        return right<UserFailure, UserData>(userData);
      } else {
        // user with id does not exist
        return left(UserNotFount());
      }
    } catch (e) {
      // Handle different error cases
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
  Future<Either<UserFailure, List<UserData>>> getByName(String name) async {
    try {
      print("userrepo -> get user by name $name"); // TODO remove
      final query = FirebaseFirestore.instance
          .collection("users")
          .where('name', isEqualTo: name);

      final matches = await query.get();

      final List<UserData> result = matches.docs.map(
        (docSnapshot) {
          UserData userData = UserModel.fromFirestore(docSnapshot).toDomain();
          return userData;
        },
      ).toList();

      return right<UserFailure, List<UserData>>(result);
    } catch (e) {
      // Handle different error cases
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
  Future<Either<UserFailure, UserData>> getCurrentUserData() async{
    try{
    final userDoc = await firestore.userDocument();
    final userSnapshot = await userDoc.get();
    if (userSnapshot.exists) {
        // user with id exists
        UserData userData = UserModel.fromFirestore(userSnapshot).toDomain();
        return right<UserFailure, UserData>(userData);
      } else {
        // user with id does not exist
        return left(UserNotFount());
      }
    } catch (e) {
      // Handle different error cases
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
