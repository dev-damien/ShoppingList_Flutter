import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:shoppinglist/03_domain/entities/user_data.dart';
import 'package:shoppinglist/03_domain/usecases/friend_usecases.dart';
import 'package:shoppinglist/03_domain/usecases/user_usecases.dart';
import 'package:shoppinglist/core/failures/friend_failures.dart';
import 'package:shoppinglist/core/failures/user_failures.dart';

part 'friend_requests_observer_event.dart';
part 'friend_requests_observer_state.dart';

class FriendRequestsObserverBloc
    extends Bloc<FriendRequestsObserverEvent, FriendRequestsObserverState> {
  final FriendUsecases friendUsecases;
  final UserUsecases userUsecases;
  StreamSubscription<Either<FriendFailure, List<String>>>? _userStreamSub;

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
          (failure) {
            emit(
              FriendRequestsObserverFailure(
                friendFailure: failure,
              ),
            );
          },
          (friendRequests) async {
            // get the data for all requester ids, such as name and profile picture
            final futures = friendRequests.map((requesterId) async {
              return await userUsecases.getUserById(requesterId);
            });

            // Wait for all futures to complete
            final values = await Future.wait(futures);

            // add only successfull UserData to list
            for (var userDataOrFailure in values) {
              userDataOrFailure.fold(
                (failure) {
                  print('friend request lead to error: ${failure.runtimeType}');
                },
                (userData) {
                  return friendRequestsWithUserData.add(userData);
                },
              );
            }
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
