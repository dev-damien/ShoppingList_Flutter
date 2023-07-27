import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shoppinglist/03_domain/entities/user_data.dart';
import 'package:shoppinglist/04_infrastructure/models/user_model.dart';
import 'package:shoppinglist/constants/default_values.dart';
import 'package:shoppinglist/core/failures/auth_failures.dart';
import 'package:dartz/dartz.dart';
import 'package:shoppinglist/03_domain/entities/user.dart';
import 'package:shoppinglist/03_domain/repositories/auth_repository.dart';
import 'package:shoppinglist/04_infrastructure/extensions/firebase_user_mapper.dart';

class AuthRepositoryImpl implements AuthRepository {
  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firestore;

  AuthRepositoryImpl({required this.firebaseAuth, required this.firestore});

  @override
  Future<Either<AuthFailure, Unit>> registerWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      // create user account
      UserCredential userCredential = await firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);

      // create basic document for user with default data
      String uuid = userCredential.user!.uid;
      final Map<String, dynamic> initUserData =
          UserModel.fromDomain(UserData.empty())
              .copyWith(
                  id: uuid,
                  name: "todo ask for name",
                  imageId: DefaultValues.defualtProfileIconId)
              .toMap();
      initUserData['createdTimestamp'] = initUserData['serverTimestamp'];
      initUserData.remove("serverTimestamp");
      firestore
          .collection("users")
          .doc(uuid)
          .set(initUserData)
          .onError((e, _) => throw Exception());

      return right(unit);
    } on FirebaseAuthException catch (e) {
      if (e.code == "email-already-in-use") {
        return left(EmailAlreadyInUseFailure());
      } else {
        return left(ServerFailure());
      }
    }
  }

  @override
  Future<Either<AuthFailure, Unit>> signInWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      await firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      return right(unit);
    } on FirebaseAuthException catch (e) {
      if (e.code == "wrong-password" || e.code == "user-not-found") {
        return left(InvalidEmailAndPasswordCombinationFailure());
      } else {
        return left(ServerFailure());
      }
    }
  }

  @override
  Future<void> signOut() => Future.wait([
        //just antoher way to await multiple futures
        firebaseAuth.signOut(),
      ]);

  @override
  Option<CustomUser> getSignedInUser() =>
      optionOf(firebaseAuth.currentUser?.toDomain());
}
