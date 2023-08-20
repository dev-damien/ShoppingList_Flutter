part of 'friend_controller_bloc.dart';

abstract class FriendControllerState extends Equatable {
  const FriendControllerState();

  @override
  List<Object> get props => [];
}

class FriendControllerInitial extends FriendControllerState {}

class FriendControllerLoading extends FriendControllerState {
  final String targetUserId;
  const FriendControllerLoading({
    required this.targetUserId,
  });
}

class FriendControllerFailure extends FriendControllerState {
  final String targetUserId;
  final FriendFailure friendFailure;
  const FriendControllerFailure({
    required this.targetUserId,
    required this.friendFailure,
  });
}

class FriendControllerSuccess extends FriendControllerState {
  final List<Friend> friends;

  const FriendControllerSuccess({
    required this.friends,
  });
}
