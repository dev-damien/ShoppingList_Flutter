// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'list_form_bloc.dart';

abstract class ListFormEvent extends Equatable {
  const ListFormEvent();

  @override
  List<Object> get props => [];
}

class InitializeListEditPage extends ListFormEvent {
  final ListData? listData;
  final bool? isFavorite;

  const InitializeListEditPage({
    this.listData,
    required this.isFavorite,
  });
}

class ToggleIsFavoriteEvent extends ListFormEvent {}

class SafePressedEvent extends ListFormEvent {
  final String? title;
  final bool? isFavorite;
  final String imageId;
  final List<Friend> members;

  const SafePressedEvent({
    this.title,
    this.isFavorite,
    required this.imageId,
    required this.members,
  });
}
