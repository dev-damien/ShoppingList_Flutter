part of 'friend_request_controller_bloc.dart';

abstract class FriendRequestControllerEvent extends Equatable {
  const FriendRequestControllerEvent();

  @override
  List<Object> get props => [];
}

class RequestFriendEvent extends FriendRequestControllerEvent {
  final String targetUserId;

  const RequestFriendEvent({
    required this.targetUserId,
  });
}
