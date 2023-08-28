import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:shoppinglist/03_domain/entities/item.dart';
import 'package:shoppinglist/03_domain/usecases/item_usecases.dart';
import 'package:shoppinglist/core/failures/item_failures.dart';

part 'items_observer_event.dart';
part 'items_observer_state.dart';

class ItemsObserverBloc extends Bloc<ItemsObserverEvent, ItemsObserverState> {
  final ItemUsecases itemUsecases;

  StreamSubscription<Either<ItemFailure, List<Item>>>? _itemStreamSub;

  ItemsObserverBloc({required this.itemUsecases})
      : super(ItemsObserverInitial()) {
    on<ObserveAllItemsEvent>((event, emit) async {
      emit(ItemsObserverLoading());
      await _itemStreamSub?.cancel();
      _itemStreamSub = itemUsecases.watchAll(event.listId).listen(
            (failureOrItems) => add(
              ItemsUpdatedEvent(failureOrItems: failureOrItems),
            ),
          );
    });
    on<ItemsUpdatedEvent>((event, emit) {
      emit(ItemsObserverLoading());
      event.failureOrItems.fold(
        (failure) {
          emit(
            ItemsObserverFailure(
              itemFailure: failure,
            ),
          );
        },
        (items) {
          emit(
            ItemsObserverSuccess(items: items),
          );
        },
      );
    });
  }
}
