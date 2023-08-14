import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:shoppinglist/03_domain/entities/user_data.dart';
import 'package:shoppinglist/03_domain/usecases/friend_usecases.dart';
import 'package:shoppinglist/03_domain/usecases/user_usecases.dart';
import 'package:shoppinglist/core/failures/user_failures.dart';

part 'friend_requests_observer_event.dart';
part 'friend_requests_observer_state.dart';

class FriendRequestsObserverBloc
    extends Bloc<FriendRequestsObserverEvent, FriendRequestsObserverState> {
  final FriendUsecases friendUsecases;
  final UserUsecases userUsecases;
  StreamSubscription<Either<UserFailure, List<String>>>? _userStreamSub;

  FriendRequestsObserverBloc({
    required this.friendUsecases,
    required this.userUsecases,
  }) : super(FriendRequestsObserverInitial()) {
    on<ObserveAllFriendRequestsEvent>(
      (event, emit) async {
        emit(FriendRequestsObserverLoading());
        await _userStreamSub?.cancel();
        _userStreamSub = friendUsecases.watchAllFriendRequests().listen(
              (failureOrUserData) => add(
                FriendRequestsUpdatedEvent(
                  failureOrFriendRequests: failureOrUserData,
                ),
              ),
            );
      },
    );
    on<FriendRequestsUpdatedEvent>(
      (event, emit) async {
        List<UserData> friendRequestsWithUserData = [];
        await event.failureOrFriendRequests.fold(
          (failures) {
            emit(
              FriendRequestsObserverFailure(
                userFailure: failures,
              ),
            );
          },
          (friendRequests) async {
            print("friend requests recieved, fold right"); // TODO remove

            print("before mapping"); // TODO remove
            // get the data for all requester ids, such as name and profile picture
            final futures = friendRequests.map((requesterId) async {
              return await userUsecases.getUserById(requesterId);
            });

            print("after mapping"); // TODO remove

            print("before await all futures"); // TODO remove
            // Wait for all futures to complete
            final values = await Future.wait(futures);
            print("after await all futures"); // TODO remove

            print("before for loop"); // TODO remove
            // add only successfull UserData to list
            for (var userDataOrFailure in values) {
              userDataOrFailure.fold(
                (failure) {
                  print(failure.runtimeType);
                },
                (userData) {
                  return friendRequestsWithUserData.add(userData);
                },
              );
            }
            print("after for loop"); // TODO remove

            // for (var requesterId in friendRequests) {
            //   final userDataOrFailure =
            //       await userUsecases.getUserById(requesterId);

            //   userDataOrFailure.fold(
            //     (failure) => null,
            //     (userData) => friendRequestsWithUserData.add(userData),
            //   );
            // }

            friendRequestsWithUserData.forEach((element) {
              print(
                  "data: id=${element.id}, name=${element.name}"); // TODO remove
            });

            print("emit success"); // TODO remove
          },
        );
        emit(
          FriendRequestsObserverSuccess(
            friendRequests: friendRequestsWithUserData,
          ),
        );
      },
    );
  }
}
