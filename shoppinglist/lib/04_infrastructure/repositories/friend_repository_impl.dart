import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:shoppinglist/03_domain/entities/friend.dart';
import 'package:shoppinglist/03_domain/repositories/friend_repository.dart';
import 'package:shoppinglist/03_domain/repositories/user_repository.dart';
import 'package:shoppinglist/04_infrastructure/extensions/firebase_helpers.dart';
import 'package:shoppinglist/04_infrastructure/models/friend_model.dart';
import 'package:shoppinglist/04_infrastructure/models/user_model.dart';
import 'package:shoppinglist/core/failures/user_failures.dart' as user_failures;
import 'package:shoppinglist/core/failures/friend_failures.dart';

class FriendRepositoryImpl implements FriendRepository {
  final FirebaseFirestore firestore;
  final UserRepository userRepository;

  FriendRepositoryImpl({required this.firestore, required this.userRepository});

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
  Stream<Either<user_failures.UserFailure, List<String>>>
      watchAllFriendRequests() async* {
    final userDoc = await firestore.userDocument();
    final Stream<DocumentSnapshot<Map<String, dynamic>>> querySnapshots =
        userDoc.snapshots() as Stream<DocumentSnapshot<Map<String, dynamic>>>;

    yield* querySnapshots.map((doc) {
      var res = UserModel.fromFirestore(doc).toDomain();
      return res;
    }).map((userData) {
      return right<user_failures.UserFailure, List<String>>(
          userData.friendRequests);
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
  Stream<Either<FriendFailure, List<Friend>>> watchAllFriends() async* {
    final userDoc = await firestore.userDocument();

    // right side: listen on friends
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
