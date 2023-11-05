import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shoppinglist/03_domain/usecases/auth_usecases.dart';
import 'package:shoppinglist/core/failures/auth_failures.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthUsecases authUsecases;

  StreamSubscription<Either<AuthFailure, User?>>? _authStreamSub;

  AuthBloc({required this.authUsecases}) : super(AuthInitial()) {
    on<SignOutPressedEvent>(
      (event, emit) async {
        await authUsecases.signOut();
        emit(AuthStateUnauthenticated());
      },
    );
    on<AuthCheckRequestedEvent>(
      (event, emit) {
        final userOption = authUsecases.getSignedInUser();
        userOption.fold(
          () => emit(
            AuthStateUnauthenticated(),
          ),
          (a) => emit(
            AuthStateAuthenticated(),
          ),
        );
      },
    );
    on<WatchAuthStateEvent>(
      (event, emit) async {
        await _authStreamSub?.cancel();
        _authStreamSub = authUsecases.watchAuthState().listen(
          (userOrFailure) {
            userOrFailure.fold(
              (failure) => null,
              (user) {
                if (user == null) {
                  add(
                    AuthCheckRequestedEvent(),
                  );
                }
              },
            );
          },
        );
      },
    );
  }
}
