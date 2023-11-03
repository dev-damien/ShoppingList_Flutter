// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'password_reset_form_bloc.dart';

abstract class PasswordResetFormState extends Equatable {
  const PasswordResetFormState();

  @override
  List<Object> get props => [];
}

class PasswordResetFormInitial extends PasswordResetFormState {}

class PasswordResetFormMailSent extends PasswordResetFormState {}

class PasswordResetFormInProgress extends PasswordResetFormState {}

class PasswordResetFormFailure extends PasswordResetFormState {
  final ResetPasswordFailure resetPasswordFailure;

  const PasswordResetFormFailure({
    required this.resetPasswordFailure,
  });
}

class PasswordResetFormSuccess extends PasswordResetFormState {}
