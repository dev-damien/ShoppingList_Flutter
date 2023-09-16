// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'list_controller_bloc.dart';

abstract class ListControllerEvent extends Equatable {
  const ListControllerEvent();

  @override
  List<Object> get props => [];
}

class DeleteListEvent extends ListControllerEvent {
  final String listId;

  const DeleteListEvent({
    required this.listId,
  });
}

class LeaveListEvent extends ListControllerEvent {
  final String listId;

  const LeaveListEvent({
    required this.listId,
  });
}
