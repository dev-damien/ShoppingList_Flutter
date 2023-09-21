import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shoppinglist/03_domain/entities/user_data.dart';
import 'package:shoppinglist/03_domain/usecases/user_usecases.dart';
import 'package:shoppinglist/core/failures/user_failures.dart';

part 'user_getter_event.dart';
part 'user_getter_state.dart';

class UserGetterBloc extends Bloc<UserGetterEvent, UserGetterState> {
  final UserUsecases userUsecases;

  UserGetterBloc({required this.userUsecases}) : super(UserGetterInitial()) {
    on<GetUserByIdEvent>((event, emit) async {
      emit(UserGetterLoading());
      final userDataOrFailure = await userUsecases.getUserById(event.userId);
      userDataOrFailure.fold(
        (failure) {
          emit(UserGetterFailure(userFailure: failure));
        },
        (userData) {
          emit(UserGetterSuccess(userData: userData));
        },
      );
    });
  }
}
