part of 'list_controller_bloc.dart';

abstract class ListControllerState extends Equatable {
  const ListControllerState();

  @override
  List<Object> get props => [];
}

class ListControllerInitial extends ListControllerState {}

class ListControllerInProgress extends ListControllerState {}

class ListControllerSuccess extends ListControllerState {}

class ListControllerFailure extends ListControllerState {
  final ListFailure listFailure;

  const ListControllerFailure({required this.listFailure});
}
