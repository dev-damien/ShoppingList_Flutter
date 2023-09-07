// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'list_form_bloc.dart';

abstract class ListFormEvent extends Equatable {
  const ListFormEvent();

  @override
  List<Object> get props => [];
}

class InitializeListEditPage extends ListFormEvent {
  final ListData? listData;
  final List<Friend>? friends;
  final bool? isFavorite;

  const InitializeListEditPage({
    this.listData,
    required this.friends,
    required this.isFavorite,
  });
}

class ToggleIsFavoriteEvent extends ListFormEvent {}

class DataChangedEvent extends ListFormEvent {
  final String? title;
  final String? imageId;

  const DataChangedEvent({
    this.title,
    this.imageId,
  });
}

class AddMemberEvent extends ListFormEvent {
  final Friend user;

  const AddMemberEvent({
    required this.user,
  });
}

class RemoveMemberEvent extends ListFormEvent {
  final Friend user;

  const RemoveMemberEvent({
    required this.user,
  });
}

class SafePressedEvent extends ListFormEvent {
  final String title;
  final bool isFavorite;
  final String imageId;
  final List<Friend> members;

  const SafePressedEvent({
    required this.title,
    required this.isFavorite,
    required this.imageId,
    required this.members,
  });
}
