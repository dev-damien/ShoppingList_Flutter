import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:shoppinglist/03_domain/entities/friend.dart';
import 'package:shoppinglist/core/failures/friend_failures.dart';

part 'friends_observer_event.dart';
part 'friends_observer_state.dart';

class FriendsObserverBloc extends Bloc<FriendsObserverEvent, FriendsObserverState> {
  FriendsObserverBloc() : super(FriendsObserverInitial()) {
    on<FriendsObserverEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
