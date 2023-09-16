// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'items_observer_bloc.dart';

abstract class ItemsObserverEvent extends Equatable {
  const ItemsObserverEvent();

  @override
  List<Object> get props => [];
}

class ObserveAllItemsEvent extends ItemsObserverEvent {
  final String listId;

  const ObserveAllItemsEvent({
    required this.listId,
  });
}

class ItemsUpdatedEvent extends ItemsObserverEvent {
  final Either<ItemFailure, List<Item>> failureOrItems;

  const ItemsUpdatedEvent({required this.failureOrItems});
}
