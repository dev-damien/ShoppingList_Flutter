part of 'user_controller_bloc.dart';

abstract class UserControllerState extends Equatable {
  const UserControllerState();

  @override
  List<Object> get props => [];
}

class UserControllerInitial extends UserControllerState {}

class UserControllerInProgress extends UserControllerState {}

class UserControllerSuccess extends UserControllerState {}

class UserControllerFailure extends UserControllerState {
  final UserFailure userFailure;

  const UserControllerFailure({required this.userFailure});
}
