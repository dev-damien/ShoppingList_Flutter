part of 'list_observer_bloc.dart';

abstract class ListObserverState extends Equatable {
  const ListObserverState();

  @override
  List<Object> get props => [];
}

class ListObserverInitial extends ListObserverState {}

class ListObserverLoading extends ListObserverState {}

class ListObserverFailure extends ListObserverState {
  final ListFailure listFailure;
  const ListObserverFailure({
    required this.listFailure,
  });
}

class ListObserverSuccess extends ListObserverState {
  final ListData listData;
  const ListObserverSuccess({
    required this.listData,
  });
}
