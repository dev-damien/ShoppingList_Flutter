part of 'items_controller_bloc.dart';

abstract class ItemsControllerState extends Equatable {
  const ItemsControllerState();
  
  @override
  List<Object> get props => [];
}

class ItemsControllerInitial extends ItemsControllerState {}
