part of 'user_controller_bloc.dart';

abstract class UserControllerEvent extends Equatable {
  const UserControllerEvent();

  @override
  List<Object> get props => [];
}

class DeleteUserEvent extends UserControllerEvent {}

class UpdateUserEvent extends UserControllerEvent {
  final UserData userData;

  const UpdateUserEvent({
    required this.userData,
  });
}