part of 'friend_controller_bloc.dart';

@immutable
abstract class FriendControllerEvent extends Equatable {
  const FriendControllerEvent();

  @override
  List<Object> get props => [];
}

class RequestFriendEvent extends FriendControllerEvent {
  final String targetUserId;

  const RequestFriendEvent({
    required this.targetUserId,
  });
}

class AddFriendEvent extends FriendControllerEvent {
  final Friend friend;

  const AddFriendEvent({
    required this.friend,
  });
}

class UpdateFriendEvent extends FriendControllerEvent {
  final Friend friend;
  final bool done;

  const UpdateFriendEvent({
    required this.friend,
    required this.done,
  });
}

class RemoveFriendEvent extends FriendControllerEvent {
  final String friendId;

  const RemoveFriendEvent({
    required this.friendId,
  });
}
