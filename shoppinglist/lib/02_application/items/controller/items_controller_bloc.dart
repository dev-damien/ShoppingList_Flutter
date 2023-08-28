import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shoppinglist/03_domain/entities/item.dart';
import 'package:shoppinglist/03_domain/usecases/item_usecases.dart';
import 'package:shoppinglist/core/failures/item_failures.dart';

part 'items_controller_event.dart';
part 'items_controller_state.dart';

class ItemsControllerBloc
    extends Bloc<ItemsControllerEvent, ItemsControllerState> {
  final ItemUsecases itemUsecases;

  ItemsControllerBloc({required this.itemUsecases})
      : super(ItemsControllerInitial()) {
    on<DeleteItemEvent>((event, emit) async {
      emit(ItemsControllerInProgress());
      final failureOrSuccess = await itemUsecases.delete(
        event.listId,
        event.item,
      );
      failureOrSuccess.fold(
          (failure) => emit(ItemsControllerFailure(itemFailure: failure)),
          (success) => emit(ItemsControllerSuccess()));
    });
    on<UpdateItemEvent>((event, emit) async {
      emit(ItemsControllerInProgress());
      final failureOrSuccess =
          await itemUsecases.update(event.listId, event.item);
      failureOrSuccess.fold(
          (failure) => emit(ItemsControllerFailure(itemFailure: failure)),
          (success) => emit(ItemsControllerSuccess()));
    });
  }
}
