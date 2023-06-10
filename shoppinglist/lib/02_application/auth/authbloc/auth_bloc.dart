import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:shoppinglist/03_domain/usecases/auth_usecases.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthUsecases authUsecases;

  AuthBloc({required this.authUsecases}) : super(AuthInitial()) {
    on<SignOutPressedEvent>(
      (event, emit) async {
        await authUsecases.signOut();
        emit(AuthStateUnauthenticated());
      },
    );
    on<AuthCheckRequestedEvent>(
      (event, emit) async {
        final userOption = authUsecases.getSignedInUser();
        userOption.fold(() => emit(AuthStateUnauthenticated()),
            (a) => emit(AuthStateAuthenticated()));
      },
    );
  }
}
