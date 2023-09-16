part of 'items_controller_bloc.dart';

abstract class ItemsControllerState extends Equatable {
  const ItemsControllerState();

  @override
  List<Object> get props => [];
}

class ItemsControllerInitial extends ItemsControllerState {}

class ItemsControllerInProgress extends ItemsControllerState {}

class ItemsControllerSuccess extends ItemsControllerState {}

class ItemsControllerFailure extends ItemsControllerState {
  final ItemFailure itemFailure;

  const ItemsControllerFailure({required this.itemFailure});
}
