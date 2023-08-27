part of 'list_observer_bloc.dart';

abstract class ListObserverEvent extends Equatable {
  const ListObserverEvent();

  @override
  List<Object> get props => [];
}

class ObserveListEvent extends ListObserverEvent {
  final String listId;

  const ObserveListEvent({
    required this.listId,
  });
}

class ListUpdatedEvent extends ListObserverEvent {
  final Either<ListFailure, ListData> failureOrListData;

  const ListUpdatedEvent({
    required this.failureOrListData,
  });
}
