import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:shoppinglist/03_domain/usecases/friend_usecases.dart';

part 'friend_controller_event.dart';
part 'friend_controller_state.dart';

class FriendControllerBloc
    extends Bloc<FriendControllerEvent, FriendControllerState> {
  final FriendUsecases friendUsecases;

  FriendControllerBloc({required this.friendUsecases})
      : super(FriendControllerInitial()) {
    on<FriendControllerEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
