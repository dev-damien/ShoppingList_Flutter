// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'password_reset_form_bloc.dart';

abstract class PasswordResetFormEvent extends Equatable {
  const PasswordResetFormEvent();

  @override
  List<Object> get props => [];
}

class SendPasswordResetMailEvent extends PasswordResetFormEvent {}

class ResetPasswordEvent extends PasswordResetFormEvent {
  final String code;
  final String newPassword;

  const ResetPasswordEvent({
    required this.code,
    required this.newPassword,
  });
}
