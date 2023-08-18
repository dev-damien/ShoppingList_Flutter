part of 'friend_controller_bloc.dart';

@immutable
abstract class FriendControllerEvent extends Equatable {
  const FriendControllerEvent();

  @override
  List<Object> get props => [];
}

class DeleteFriendEvent extends FriendControllerEvent {
  final String friendId;

  const DeleteFriendEvent({
    required this.friendId,
  });
}

class UpdateFriendEvent extends FriendControllerEvent {
  final String friendId;
  final bool done;

  const UpdateFriendEvent({
    required this.friendId,
    required this.done,
  });
}
