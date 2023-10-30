// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'user_verification_bloc.dart';

abstract class UserVerificationState extends Equatable {
  const UserVerificationState();

  @override
  List<Object> get props => [];
}

class UserVerificationInitial extends UserVerificationState {}

class UserVerificationInProgress extends UserVerificationState {}

class UserVerificationFailure extends UserVerificationState {
  final UserFailure userFailure;

  const UserVerificationFailure({
    required this.userFailure,
  });
}

class UserVerificationSuccess extends UserVerificationState {}
