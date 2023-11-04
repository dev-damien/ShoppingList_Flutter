import 'package:dartz/dartz.dart';
import 'package:shoppinglist/03_domain/entities/friend.dart';
import 'package:shoppinglist/03_domain/entities/user_data.dart';
import 'package:shoppinglist/03_domain/repositories/friend_repository.dart';
import 'package:shoppinglist/03_domain/repositories/user_repository.dart';
import 'package:shoppinglist/core/failures/friend_failures.dart';

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
    return friendRepository.acceptRequest(userId);
  }

  Future<Either<FriendFailure, Unit>> declineRequest(
    String userId,
  ) {
    return friendRepository.declineRequest(userId);
  }

  Future<Either<FriendFailure, Unit>> updateNickname(Friend friend) {
    return friendRepository.setNickname(friend.id.value, friend.nickname);
  }

  Future<Either<FriendFailure, Unit>> resetNickname(
    String userId,
  ) {
    //TODO implement
    throw UnimplementedError("Not implemented");
  }

  Future<Either<FriendFailure, Unit>> unfriendUser(
    Friend friend,
  ) async {
    final failureOrSuccess = await userRepository.getCurrentUserData();
    UserData thisUser;
    return await failureOrSuccess.fold(
      (failure) async {
        return left(UnexpectedFailure());
      },
      (user) async {
        thisUser = user;
        final failureOrSuccess =
            await friendRepository.delete(thisUser.id.value, friend.id.value);
        final failureOrSuccess2 =
            await friendRepository.delete(friend.id.value, thisUser.id.value);
        return failureOrSuccess.fold(
          (failure) {
            return left(failure);
          },
          (success) async {
            return await failureOrSuccess2.fold(
              (failure) {
                return left(failure);
              },
              (success) {
                return right(unit);
              },
            );
          },
        );
      },
    );
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

    // remove the user himself from the result list
    final user = await userRepository.getCurrentUserData();
    user.fold(
      (l) => null,
      (userData) {
        result.removeWhere(
            (resultUser) => resultUser.id.value == userData.id.value);
      },
    );

    print(
        'friend usecase -> searchUsers: input=$searchString result=${result.map((e) => e.name)}');
    return right<FriendFailure, List<UserData>>(result);
  }
}
