part of 'friends_observer_bloc.dart';

abstract class FriendsObserverEvent {}

class ObserveAllFriendsEvent extends FriendsObserverEvent {}

class FriendsUpdatedEvent extends FriendsObserverEvent {
  final Either<FriendFailure, List<Friend>> failureOrFriends;

  FriendsUpdatedEvent({required this.failureOrFriends});
}
