import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shoppinglist/03_domain/entities/item.dart';
import 'package:shoppinglist/03_domain/usecases/item_usecases.dart';

part 'items_controller_event.dart';
part 'items_controller_state.dart';

class ItemsControllerBloc
    extends Bloc<ItemsControllerEvent, ItemsControllerState> {
  final ItemUsecases itemUsecases;

  ItemsControllerBloc({required this.itemUsecases})
      : super(ItemsControllerInitial()) {
    on<ItemsControllerEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
