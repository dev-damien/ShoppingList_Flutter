import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'list_add_items_mode_event.dart';
part 'list_add_items_mode_state.dart';

class ListAddItemsModeBloc
    extends Bloc<ListAddItemsModeEvent, ListAddItemsModeState> {
  ListAddItemsModeBloc() : super(ListAddItemsModeDeactivated()) {
    on<ActivateAddItemsModeEvent>((event, emit) {
      emit(ListAddItemsModeActivated());
    });
    on<DeactivateAddItemsModeEvent>((event, emit) {
      emit(ListAddItemsModeDeactivated());
    });
  }
}
