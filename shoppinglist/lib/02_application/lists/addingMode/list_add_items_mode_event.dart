part of 'list_add_items_mode_bloc.dart';

abstract class ListAddItemsModeEvent extends Equatable {
  const ListAddItemsModeEvent();

  @override
  List<Object> get props => [];
}

class ActivateAddItemsModeEvent extends ListAddItemsModeEvent {}

class DeactivateAddItemsModeEvent extends ListAddItemsModeEvent {}
