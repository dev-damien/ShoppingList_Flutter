import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shoppinglist/03_domain/usecases/friend_usecases.dart';
import 'package:shoppinglist/core/failures/friend_failures.dart';

part 'friend_request_controller_event.dart';
part 'friend_request_controller_state.dart';

class FriendRequestControllerBloc
    extends Bloc<FriendRequestControllerEvent, FriendRequestControllerState> {
  final FriendUsecases friendUsecases;

  FriendRequestControllerBloc({required this.friendUsecases})
      : super(FriendRequestControllerInitial()) {
    on<RequestFriendEvent>((event, emit) async {
      emit(
        FriendRequestControllerLoading(
          targetUserId: event.targetUserId,
        ),
      );
      await Future.delayed(Duration(seconds: 2)); //todo !!!remove fake wait
      final targetUserId = event.targetUserId;
      final failureOrSuccess = await friendUsecases.addRequest(targetUserId);
      failureOrSuccess.fold(
        (failure) {
          emit(
            FriendRequestControllerFailure(
              targetUserId: targetUserId,
              friendFailure: failure,
            ),
          );
        },
        (success) {
          emit(
            FriendRequestControllerSuccess(
              targetUserId: targetUserId,
            ),
          );
        },
      );
    });
  }
}
