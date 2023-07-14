import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:shoppinglist/03_domain/entities/friend.dart';
import 'package:shoppinglist/03_domain/repositories/friend_repository.dart';
import 'package:shoppinglist/04_infrastructure/extensions/firebase_helpers.dart';
import 'package:shoppinglist/04_infrastructure/models/friend_model.dart';
import 'package:shoppinglist/core/failures/friend_failures.dart';

class FriendRepositoryImpl implements FriendRepository {
  final FirebaseFirestore firestore;

  FriendRepositoryImpl({required this.firestore});

  @override
  Future<Either<FriendFailure, Unit>> acceptRequest(String userId) {
    // TODO: implement acceptRequest
    throw UnimplementedError();
  }

  @override
  Future<Either<FriendFailure, Unit>> addRequest(String userId) {
    // TODO: implement addRequest
    throw UnimplementedError();
  }

  @override
  Future<Either<FriendFailure, Unit>> declineRequest(String userId) {
    // TODO: implement declineRequest
    throw UnimplementedError();
  }

  @override
  Future<Either<FriendFailure, Unit>> resetNickname(String userId) {
    // TODO: implement resetNickname
    throw UnimplementedError();
  }

  @override
  Future<Either<FriendFailure, Unit>> setNickname(
      String userId, String nickname) {
    // TODO: implement setNickname
    throw UnimplementedError();
  }

  @override
  Stream<Either<FriendFailure, List<String>>> watchAllFriendRequests() {
    // TODO: implement watchAllFriendRequests
    throw UnimplementedError();
  }

  @override
  Stream<Either<FriendFailure, List<Friend>>> watchAllFriends() async* {
    final userDoc = await firestore.userDocument();

    // right side: listen on list_previews
    yield* userDoc.friendPreviewCollection
        .snapshots()
        .map((snapshot) => right<FriendFailure, List<Friend>>(snapshot.docs
            .map((doc) => FriendModel.fromFirestore(doc).toDomain())
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
