import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:shoppinglist/03_domain/entities/friend.dart';
import 'package:shoppinglist/03_domain/usecases/friend_usecases.dart';
import 'package:shoppinglist/core/failures/friend_failures.dart';

part 'friend_controller_event.dart';
part 'friend_controller_state.dart';

class FriendControllerBloc
    extends Bloc<FriendControllerEvent, FriendControllerState> {
  final FriendUsecases friendUsecases;

  FriendControllerBloc({required this.friendUsecases})
      : super(FriendControllerInitial()) {
    on<RequestFriendEvent>((event, emit) {
      
    });
    on<AddFriendEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<UpdateFriendEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<RemoveFriendEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
