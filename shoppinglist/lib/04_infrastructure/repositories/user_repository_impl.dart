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
  Stream<Either<UserFailure, Unit>> watch() {
    // TODO: implement watchAll
    throw UnimplementedError();
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
}
