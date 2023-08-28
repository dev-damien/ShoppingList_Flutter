import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'items_controller_event.dart';
part 'items_controller_state.dart';

class ItemsControllerBloc extends Bloc<ItemsControllerEvent, ItemsControllerState> {
  ItemsControllerBloc() : super(ItemsControllerInitial()) {
    on<ItemsControllerEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
