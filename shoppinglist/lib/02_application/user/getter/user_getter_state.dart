part of 'user_getter_bloc.dart';

abstract class UserGetterState extends Equatable {
  const UserGetterState();

  @override
  List<Object> get props => [];
}

class UserGetterInitial extends UserGetterState {}

class UserGetterLoading extends UserGetterState {}

class UserGetterFailure extends UserGetterState {
  final UserFailure userFailure;
  const UserGetterFailure({required this.userFailure});
}

class UserGetterSuccess extends UserGetterState {
  final UserData userData;
  const UserGetterSuccess({required this.userData});
}
