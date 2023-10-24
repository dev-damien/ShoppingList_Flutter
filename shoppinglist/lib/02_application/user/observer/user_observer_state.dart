part of 'user_observer_bloc.dart';

abstract class UserObserverState {}

class UserObserverInitial extends UserObserverState {}

class UserObserverLoading extends UserObserverState {}

class UserObserverFailure extends UserObserverState {
  final UserFailure userFailure;
  UserObserverFailure({required this.userFailure});
}

class UserObserverSuccess extends UserObserverState {
  final UserData userData;
  final bool isEmailAuhenticated;
  UserObserverSuccess({
    required this.userData,
    required this.isEmailAuhenticated,
  });
}
