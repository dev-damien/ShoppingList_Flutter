import 'package:dartz/dartz.dart';
import 'package:shoppinglist/03_domain/entities/friend.dart';
import 'package:shoppinglist/03_domain/entities/user_data.dart';
import 'package:shoppinglist/03_domain/repositories/friend_repository.dart';
import 'package:shoppinglist/03_domain/repositories/user_repository.dart';
import 'package:shoppinglist/core/failures/friend_failures.dart';
import 'package:shoppinglist/core/failures/user_failures.dart';

class FriendUsecases {
  final FriendRepository friendRepository;
  final UserRepository userRepository;

  FriendUsecases({
    required this.friendRepository,
    required this.userRepository,
  });

  Stream<Either<FriendFailure, List<Friend>>> watchAllFriends() {
    return friendRepository.watchAllFriends();
  }

  Stream<Either<FriendFailure, List<String>>> watchAllFriendRequests() {
    return friendRepository.watchAllFriendRequests();
  }

  Stream<Either<FriendFailure, List<String>>> watchAllFriendRequestsSent() {
    return friendRepository.watchAllFriendRequestsSent();
  }

  Future<Either<FriendFailure, Unit>> addRequest(
    String userId,
  ) {
    return friendRepository.addRequest(userId);
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

  Future<Either<FriendFailure, List<UserData>>> searchUsers(
      String searchString) async {
    final matchedId = await userRepository.getById(searchString);
    final matchedName = await userRepository.getByName(searchString);
    List<UserData> result = List.empty(growable: true);

    matchedId.fold(
      (failure) {
        // no user with this id found
      },
      (user) {
        // user with id found
        result.add(user);
      },
    );
    matchedName.fold(
      (failure) {
        // error occured
      },
      (users) {
        // list of users where name matches search string
        result.addAll(users);
      },
    );

    print(
        'friend usecase -> searchUsers: input=$searchString result=${result.map((e) => e.name)}'); //TODO remove debug print
    return right<FriendFailure, List<UserData>>(result);
  }
}
