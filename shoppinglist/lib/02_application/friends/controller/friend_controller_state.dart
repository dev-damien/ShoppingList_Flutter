part of 'friend_controller_bloc.dart';

abstract class FriendControllerState extends Equatable {
  const FriendControllerState();

  @override
  List<Object> get props => [];
}

class FriendControllerInitial extends FriendControllerState {}

class FriendControllerInProgress extends FriendControllerState {
  final Friend friend;
  const FriendControllerInProgress({
    required this.friend,
  });
}

class FriendControllerFailure extends FriendControllerState {
  final Friend friend;
  final FriendFailure friendFailure;
  const FriendControllerFailure({
    required this.friend,
    required this.friendFailure,
  });
}

class FriendControllerSuccess extends FriendControllerState {
  final Friend friend;

  const FriendControllerSuccess({
    required this.friend,
  });
}
