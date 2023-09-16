part of 'list_add_items_mode_bloc.dart';

abstract class ListAddItemsModeState extends Equatable {
  const ListAddItemsModeState();

  @override
  List<Object> get props => [];
}

class ListAddItemsModeDeactivated extends ListAddItemsModeState {}

class ListAddItemsModeActivated extends ListAddItemsModeState {}
