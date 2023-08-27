import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:shoppinglist/03_domain/entities/list.dart';
import 'package:shoppinglist/03_domain/usecases/list_usecases.dart';
import 'package:shoppinglist/core/failures/list_failures.dart';

part 'list_observer_event.dart';
part 'list_observer_state.dart';

class ListObserverBloc extends Bloc<ListObserverEvent, ListObserverState> {
  final ListUsecases listUsecases;

  StreamSubscription<Either<ListFailure, ListData>>? _listStreamSub;

  ListObserverBloc({required this.listUsecases})
      : super(ListObserverInitial()) {
    on<ObserveListEvent>(
      (event, emit) async {
        emit(ListObserverLoading());
        await _listStreamSub?.cancel();
        _listStreamSub = listUsecases.watch(event.listId).listen(
              (failureOrListData) => add(
                ListUpdatedEvent(failureOrListData: failureOrListData),
              ),
            );
      },
    );
    on<ListUpdatedEvent>(
      (event, emit) {
        event.failureOrListData.fold(
          (failure) => emit(
            ListObserverFailure(
              listFailure: failure,
            ),
          ),
          (listData) => emit(
            ListObserverSuccess(
              listData: listData,
            ),
          ),
        );
      },
    );
  }
}
