import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:shoppinglist/03_domain/entities/user_data.dart';
import 'package:shoppinglist/03_domain/usecases/auth_usecases.dart';
import 'package:shoppinglist/03_domain/usecases/user_usecases.dart';
import 'package:shoppinglist/core/failures/user_failures.dart';

part 'user_observer_event.dart';
part 'user_observer_state.dart';

class UserObserverBloc extends Bloc<UserObserverEvent, UserObserverState> {
  final UserUsecases userUsecases;
  final AuthUsecases authUsecases;

  StreamSubscription<Either<UserFailure, UserData>>? _userStreamSub;

  UserObserverBloc({
    required this.userUsecases,
    required this.authUsecases,
  }) : super(UserObserverInitial()) {
    on<ObserveUserEvent>(
      (event, emit) async {
        emit(UserObserverLoading());
        await _userStreamSub?.cancel();
        _userStreamSub = userUsecases.watch().listen(
              (failureOrUserData) => add(
                UserUpdatedEvent(failureOrUserData: failureOrUserData),
              ),
            );
      },
    );
    on<UserUpdatedEvent>(
      (event, emit) {
        event.failureOrUserData.fold(
          (failure) => emit(
            UserObserverFailure(
              userFailure: failure,
            ),
          ),
          (userData) async {
            final isEmailAuthenticated =
                await authUsecases.isEmailAuthenticated();
            emit(
              UserObserverSuccess(
                userData: userData,
                isEmailAuhenticated: isEmailAuthenticated,
              ),
            );
          },
        );
      },
    );
  }
}
