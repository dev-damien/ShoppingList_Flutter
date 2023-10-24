import 'package:dartz/dartz.dart';
import 'package:shoppinglist/03_domain/entities/friend.dart';
import 'package:shoppinglist/03_domain/entities/user_data.dart';
import 'package:shoppinglist/03_domain/repositories/auth_repository.dart';
import 'package:shoppinglist/03_domain/repositories/friend_repository.dart';
import 'package:shoppinglist/03_domain/repositories/user_repository.dart';
import 'package:shoppinglist/core/failures/user_failures.dart';

class UserUsecases {
  final UserRepository userRepository;
  final AuthRepository authRepository;
  final FriendRepository friendRepository;

  UserUsecases({
    required this.userRepository,
    required this.authRepository,
    required this.friendRepository,
  });

  Stream<Either<UserFailure, UserData>> watch() {
    return userRepository.watch();
  }

  Future<Either<UserFailure, UserData>> getUserById(String id) async {
    return await userRepository.getById(id);
  }

  Future<Either<UserFailure, UserData>> getCurrentUserData() async {
    return await userRepository.getCurrentUserData();
  }

  Future<Either<UserFailure, Unit>> delete() async {
    // delete user document
    await userRepository.deleteDocument();

    // delete all connections of user
    await userRepository.purgeUserConnections();

    // delete user in firebase
    await authRepository.deleteAccount();

    return right(unit);
  }

  Future<Either<UserFailure, Unit>> updateData(UserData newUserData) async {
    final userDataOrFailure = await userRepository.getCurrentUserData();
    userDataOrFailure.fold(
      (failure) {
        return left(failure);
      },
      (oldUserData) async {
        // update name and image in main user doc
        final updatedUserData = oldUserData.copyWith(
          name: newUserData.name != "" ? newUserData.name : oldUserData.name,
          imageId: newUserData.imageId != ""
              ? newUserData.imageId
              : oldUserData.imageId,
        );
        userRepository.update(updatedUserData);

        // if name gets changed, update in other users frindslist
        if (newUserData.name != "") {
          friendRepository.updateOwnNameForFriends(newUserData.name);
        }
      },
    );
    return right(unit);
  }
}
