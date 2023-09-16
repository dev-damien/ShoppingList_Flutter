part of 'friend_request_respond_bloc.dart';

abstract class FriendRequestRespondState extends Equatable {
  const FriendRequestRespondState();

  @override
  List<Object> get props => [];
}

class FriendRequestRespondInitial extends FriendRequestRespondState {}

class FriendRequestRespondLoading extends FriendRequestRespondState {
  final String targetUserId;
  final FriendRequestResponse type;
  const FriendRequestRespondLoading({
    required this.targetUserId,
    required this.type,
  });
}

class FriendRequestRespondFailure extends FriendRequestRespondState {
  final String targetUserId;
  final FriendRequestResponse type;
  final FriendFailure failure;
  const FriendRequestRespondFailure({
    required this.targetUserId,
    required this.type,
    required this.failure,
  });
}

class FriendRequestRespondSuccess extends FriendRequestRespondState {
  final String targetUserId;
  final FriendRequestResponse type;
  const FriendRequestRespondSuccess({
    required this.targetUserId,
    required this.type,
  });
}
