part of 'friend_requests_observer_bloc.dart';

@immutable
abstract class FriendRequestsObserverState {}

class FriendRequestsObserverInitial extends FriendRequestsObserverState {}

class FriendRequestsObserverLoading extends FriendRequestsObserverState {}

class FriendRequestsObserverFailure extends FriendRequestsObserverState {
  final UserFailure userFailure;
  FriendRequestsObserverFailure({required this.userFailure});
}

class FriendRequestsObserverSuccess extends FriendRequestsObserverState {
  final List<UserData> friendRequests;

  FriendRequestsObserverSuccess({required this.friendRequests});
}
