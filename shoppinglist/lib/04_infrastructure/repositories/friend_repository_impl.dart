import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:shoppinglist/03_domain/entities/friend.dart';
import 'package:shoppinglist/03_domain/entities/user_data.dart';
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
      return right<user_failures.UserFailure, List<String>>(userData.friendRequests);
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








// @override
//   Stream<Either<user_failures.UserFailure, List<String>>>
//       watchAllFriendRequests() async* {
//     final userDoc = await firestore.userDocument();

//     final Stream<DocumentSnapshot<Map<String, dynamic>>> querySnapshots =
//         userDoc.snapshots() as Stream<DocumentSnapshot<Map<String, dynamic>>>;

//     yield* querySnapshots.map((doc) {
//       // transform retrieved data to UserData object
//       UserData res = UserModel.fromFirestore(doc).toDomain();
//       print("friendrepo -> user: $res");

//       return res;
//     }).map((userData) async {
//       // get list of friendrequests
//       List<String> requests = userData.friendRequests;
//       print("friendrepo -> requests: $requests");
//       return requests;

//       // fetch account data of the requesters
//       // List<Future<Either<user_failures.UserFailure, UserData>>> requesterData =
//       //     requests.map((id) => userRepository.getById(id)).toList();
//       // List<Either<user_failures.UserFailure, UserData>> results =
//       //     await Future.wait(requesterData);
//       // List<UserData> resultsClean = results
//       //     .where((element) => element.isRight())
//       //     .map((either) => either.fold(
//       //           (failure) => throw Exception("This should never happen"),
//       //           (userData) => userData,
//       //         ))
//       //     .toList();

//       //print("friendrepo -> requesterData: $requesterData");
//       //return resultsClean;
//     }).map(await (requests) {
//       // Exception has occurred.
//       // _TypeError (type 'Future<List<UserData>>' is not a subtype of type 'List<UserData>')
//       return right<user_failures.UserFailure, List<String>>(requests);
//     }).handleError((e) {
//       // Handle different error cases
//       if (e is FirebaseException) {
//         if (e.code.contains("permission-denied") ||
//             e.code.contains("PERMISSION_DENIED")) {
//           return left(user_failures.InsufficientPermissions());
//         } else {
//           return left(user_failures.UnexpectedFailureFirebase());
//         }
//       } else {
//         return left(user_failures.UnexpectedFailure());
//       }
//     });
//   }
