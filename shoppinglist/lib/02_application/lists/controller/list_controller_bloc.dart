import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shoppinglist/03_domain/entities/list.dart';
import 'package:shoppinglist/03_domain/usecases/list_usecases.dart';
import 'package:shoppinglist/core/failures/list_failures.dart';

part 'list_controller_event.dart';
part 'list_controller_state.dart';

class ListControllerBloc
    extends Bloc<ListControllerEvent, ListControllerState> {
  final ListUsecases listUsecases;

  ListControllerBloc({required this.listUsecases})
      : super(ListControllerInitial()) {
    on<DeleteListEvent>((event, emit) async {
      emit(ListControllerInProgress());
      final failureOrSuccess = await listUsecases.delete(
        event.listId,
      );
      failureOrSuccess.fold(
          (failure) => emit(ListControllerFailure(listFailure: failure)),
          (success) => emit(ListControllerSuccess()));
    });
    on<LeaveListEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
