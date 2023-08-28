part of 'items_controller_bloc.dart';

abstract class ItemsControllerEvent extends Equatable {
  const ItemsControllerEvent();

  @override
  List<Object> get props => [];
}

class DeleteItemEvent extends ItemsControllerEvent {
  final Item item;

  const DeleteItemEvent({
    required this.item,
  });
}

class UpdateItemEvent extends ItemsControllerEvent {
  final Item item;

  const UpdateItemEvent({
    required this.item,
  });
}
