import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shoppinglist/03_domain/entities/user_data.dart';
import 'package:shoppinglist/03_domain/usecases/user_usecases.dart';
import 'package:shoppinglist/core/failures/user_failures.dart';

part 'user_controller_event.dart';
part 'user_controller_state.dart';

class UserControllerBloc
    extends Bloc<UserControllerEvent, UserControllerState> {
  final UserUsecases userUsecases;

  UserControllerBloc({required this.userUsecases})
      : super(UserControllerInitial()) {
    on<UpdateUserEvent>((event, emit) async {
      emit(UserControllerInProgress());
      final failureOrSuccess = await userUsecases.updateData(event.userData);
      failureOrSuccess.fold(
          (failure) => emit(UserControllerFailure(userFailure: failure)),
          (success) => emit(UserControllerSuccess()));
    });
    on<DeleteUserEvent>((event, emit) async {
      emit(UserControllerInProgress());
      final failureOrSuccess = await userUsecases.delete();
      failureOrSuccess.fold(
          (failure) => emit(UserControllerFailure(userFailure: failure)),
          (success) => emit(UserControllerSuccess()));
    });
  }
}
