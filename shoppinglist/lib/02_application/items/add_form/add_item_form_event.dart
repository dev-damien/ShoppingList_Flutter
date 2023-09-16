part of 'add_item_form_bloc.dart';

abstract class ItemAddFormEvent extends Equatable {
  const ItemAddFormEvent();

  @override
  List<Object> get props => [];
}

class InitializeItemAddFormEvent extends ItemAddFormEvent {}

class SafePressedEvent extends ItemAddFormEvent {
  final String listId;
  final int? number;
  final String? title;

  const SafePressedEvent({
    required this.listId,
    required this.number,
    required this.title,
  });
}
