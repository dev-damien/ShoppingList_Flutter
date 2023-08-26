import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:shoppinglist/03_domain/entities/user_data.dart';
import 'package:shoppinglist/03_domain/usecases/user_usecases.dart';
import 'package:shoppinglist/core/failures/user_failures.dart';

part 'user_observer_event.dart';
part 'user_observer_state.dart';

class UserObserverBloc extends Bloc<UserObserverEvent, UserObserverState> {
  final UserUsecases userUsecases;

  StreamSubscription<Either<UserFailure, UserData>>? _userStreamSub;

  UserObserverBloc({required this.userUsecases})
      : super(UserObserverInitial()) {
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
          (failures) => emit(
            UserObserverFailure(
              userFailure: failures,
            ),
          ),
          (userData) => emit(
            UserObserverSuccess(userData: userData),
          ),
        );
      },
    );
  }
}
