import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:shoppinglist/03_domain/entities/friend.dart';
import 'package:shoppinglist/03_domain/usecases/friend_usecases.dart';
import 'package:shoppinglist/core/failures/friend_failures.dart';

part 'friends_observer_event.dart';
part 'friends_observer_state.dart';

class FriendsObserverBloc
    extends Bloc<FriendsObserverEvent, FriendsObserverState> {
  final FriendUsecases friendUsecases;
  StreamSubscription<Either<FriendFailure, List<Friend>>>? _friendStreamSub;

  FriendsObserverBloc({required this.friendUsecases})
      : super(FriendsObserverInitial()) {
    on<ObserveAllFriendsEvent>((event, emit) async {
      emit(FriendsObserverLoading());
      await _friendStreamSub?.cancel();
      _friendStreamSub = friendUsecases.watchAllFriends().listen(
            (failureOrFriends) => add(
              FriendsUpdatedEvent(
                failureOrFriends: failureOrFriends,
              ),
            ),
          );
    });
    on<FriendsUpdatedEvent>(
      (event, emit) {
        event.failureOrFriends.fold(
          (failures) => emit(
            FriendsObserverFailure(
              friendFailure: failures,
            ),
          ),
          (friends) => emit(
            FriendsObserverSuccess(
              friends: friends,
            ),
          ),
        );
      },
    );
  }

  @override
  Future<void> close() async {
    await _friendStreamSub?.cancel();
    return super.close();
  }
}
