import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'friends_observer_event.dart';
part 'friends_observer_state.dart';

class FriendsObserverBloc extends Bloc<FriendsObserverEvent, FriendsObserverState> {
  FriendsObserverBloc() : super(FriendsObserverInitial()) {
    on<FriendsObserverEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
