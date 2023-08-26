part of 'friend_search_form_bloc.dart';

abstract class FriendSearchFormEvent {}

class SearchUserEvent extends FriendSearchFormEvent {
  final String searchString;

  SearchUserEvent({required this.searchString});
}
