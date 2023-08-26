part of 'friend_request_respond_bloc.dart';

abstract class FriendRequestRespondEvent extends Equatable {
  const FriendRequestRespondEvent();

  @override
  List<Object> get props => [];
}

class AcceptFriendRequestEvent extends FriendRequestRespondEvent {
  final String targetUserId;

  const AcceptFriendRequestEvent({
    required this.targetUserId,
  });
}

class DeclineFriendRequestEvent extends FriendRequestRespondEvent {
  final String targetUserId;

  const DeclineFriendRequestEvent({
    required this.targetUserId,
  });
}

class BlockUserEvent extends FriendRequestRespondEvent {
  final String targetUserId;

  const BlockUserEvent({
    required this.targetUserId,
  });
}
