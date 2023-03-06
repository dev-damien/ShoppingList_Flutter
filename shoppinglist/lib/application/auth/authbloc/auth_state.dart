part of 'auth_bloc.dart';

@immutable
abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuttStateAuthenticated extends AuthState {}

class AuthStateUnauthenticated extends AuthState {}
