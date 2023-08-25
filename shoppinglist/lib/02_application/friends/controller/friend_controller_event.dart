part of 'friend_controller_bloc.dart';

@immutable
abstract class FriendControllerEvent extends Equatable {
  const FriendControllerEvent();

  @override
  List<Object> get props => [];
}

class UpdateFriendNicknameEvent extends FriendControllerEvent {
  final Friend friend;
  final String nickname;

  const UpdateFriendNicknameEvent({
    required this.friend,
    required this.nickname,
  });
}

class RemoveFriendEvent extends FriendControllerEvent {
  final Friend friend;

  const RemoveFriendEvent({
    required this.friend,
  });
}
