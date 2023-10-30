part of 'user_verification_bloc.dart';

abstract class UserVerificationEvent extends Equatable {
  const UserVerificationEvent();

  @override
  List<Object> get props => [];
}

class sendVerificationMail extends UserVerificationEvent {}
