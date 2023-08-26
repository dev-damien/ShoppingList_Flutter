part of 'friends_observer_bloc.dart';

@immutable
abstract class FriendsObserverState {}

class FriendsObserverInitial extends FriendsObserverState {}

class FriendsObserverLoading extends FriendsObserverState {}

class FriendsObserverFailure extends FriendsObserverState {
  final FriendFailure friendFailure;
  FriendsObserverFailure({required this.friendFailure});
}

class FriendsObserverSuccess extends FriendsObserverState {
  final List<Friend> friends;

  FriendsObserverSuccess({required this.friends});
}
