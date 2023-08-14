part of 'friend_requests_observer_bloc.dart';

abstract class FriendRequestsObserverEvent {}

class ObserveAllFriendRequestsEvent extends FriendRequestsObserverEvent {}

class FriendRequestsUpdatedEvent extends FriendRequestsObserverEvent {
  final Either<UserFailure, List<String>> failureOrFriendRequests;

  FriendRequestsUpdatedEvent({required this.failureOrFriendRequests});
}
