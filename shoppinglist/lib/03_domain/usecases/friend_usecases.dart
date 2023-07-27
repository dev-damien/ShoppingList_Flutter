import 'package:dartz/dartz.dart';
import 'package:shoppinglist/03_domain/entities/friend.dart';
import 'package:shoppinglist/03_domain/repositories/friend_repository.dart';
import 'package:shoppinglist/core/failures/friend_failures.dart';

class FriendUsecases {
  final FriendRepository friendRepository;

  FriendUsecases({
    required this.friendRepository,
  });

  Stream<Either<FriendFailure, List<Friend>>> watchAllFriends() {
    //TODO implement
    throw UnimplementedError("Not implemented");
  }

  Stream<Either<FriendFailure, List<String>>> watchAllFriendRequests() {
    //TODO implement
    throw UnimplementedError("Not implemented");
  }

  Future<Either<FriendFailure, Unit>> addRequest(
    String userId,
  ) {
    //TODO implement
    throw UnimplementedError("Not implemented");
  }

  Future<Either<FriendFailure, Unit>> acceptRequest(
    String userId,
  ) {
    //TODO implement
    throw UnimplementedError("Not implemented");
  }

  Future<Either<FriendFailure, Unit>> declineRequest(
    String userId,
  ) {
    //TODO implement
    throw UnimplementedError("Not implemented");
  }

  Future<Either<FriendFailure, Unit>> setNickname(
    String userId,
    String nickname,
  ) {
    //TODO implement
    throw UnimplementedError("Not implemented");
  }

  Future<Either<FriendFailure, Unit>> resetNickname(
    String userId,
  ) {
    //TODO implement
    throw UnimplementedError("Not implemented");
  }
}
