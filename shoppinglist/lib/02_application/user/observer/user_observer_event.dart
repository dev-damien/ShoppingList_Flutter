part of 'user_observer_bloc.dart';

abstract class UserObserverEvent {}

class ObserveUserEvent extends UserObserverEvent {}

class UserUpdatedEvent extends UserObserverEvent {
  final Either<UserFailure, UserData> failureOrUserData;

  UserUpdatedEvent({required this.failureOrUserData});
}
