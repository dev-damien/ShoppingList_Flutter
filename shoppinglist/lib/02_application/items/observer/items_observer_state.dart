// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'items_observer_bloc.dart';

abstract class ItemsObserverState extends Equatable {
  const ItemsObserverState();

  @override
  List<Object> get props => [];
}

class ItemsObserverInitial extends ItemsObserverState {}

class ItemsObserverLoading extends ItemsObserverState {}

class ItemsObserverFailure extends ItemsObserverState {
  final ItemFailure itemFailure;
  const ItemsObserverFailure({
    required this.itemFailure,
  });
}

class ItemsObserverSuccess extends ItemsObserverState {
  final List<Item> items;
  const ItemsObserverSuccess({
    required this.items,
  });
}
