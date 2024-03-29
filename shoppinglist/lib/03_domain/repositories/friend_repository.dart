import 'package:dartz/dartz.dart';
import 'package:shoppinglist/03_domain/entities/friend.dart';
import 'package:shoppinglist/core/failures/friend_failures.dart';

abstract class FriendRepository {
  Stream<Either<FriendFailure, List<Friend>>> watchAllFriends();

  Stream<Either<FriendFailure, List<String>>> watchAllFriendRequests();

  Stream<Either<FriendFailure, List<String>>> watchAllFriendRequestsSent();

  Future<Either<FriendFailure, Unit>> addRequest(String userId);

  Future<Either<FriendFailure, Unit>> acceptRequest(
    String userId,
  );

  Future<Either<FriendFailure, Unit>> declineRequest(
    String userId,
  );

  Future<Either<FriendFailure, Unit>> create(
      String userIdDocGetsAddedHere, Friend friend);

  Future<Either<FriendFailure, Unit>> delete(
    String userIdDocGetsDeletedHere, String friendId,
  );

  Future<Either<FriendFailure, Unit>> setNickname(
    String userId,
    String nickname,
  );

  Future<Either<FriendFailure, Unit>> resetNickname(
    String userId,
  );

//TODO add later as nice to have
  // Future<Either<FriendFailure, Unit>> blockUser(
  //   String userId,
  // );

  // Future<Either<FriendFailure, Unit>> unblockUser(
  //   String userId,
  // );
}
