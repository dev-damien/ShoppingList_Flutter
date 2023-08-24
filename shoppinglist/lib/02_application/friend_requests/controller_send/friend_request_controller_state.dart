part of 'friend_request_controller_bloc.dart';

abstract class FriendRequestControllerState extends Equatable {
  const FriendRequestControllerState();

  @override
  List<Object> get props => [];
}

class FriendRequestControllerInitial extends FriendRequestControllerState {}

class FriendRequestControllerLoading extends FriendRequestControllerState {
  final String targetUserId;
  const FriendRequestControllerLoading({
    required this.targetUserId,
  });
}

class FriendRequestControllerFailure extends FriendRequestControllerState {
  final String targetUserId;
  final FriendFailure friendFailure;

  const FriendRequestControllerFailure({
    required this.targetUserId,
    required this.friendFailure,
  });
}

class FriendRequestControllerSuccess extends FriendRequestControllerState {
  final String targetUserId;

  const FriendRequestControllerSuccess({
    required this.targetUserId,
  });
}
