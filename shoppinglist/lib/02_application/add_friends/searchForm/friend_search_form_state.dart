part of 'friend_search_form_bloc.dart';

class FriendSearchFormState {
  List<UserData>? matchedUsers;
  final bool showErrorMessages;
  FriendFailure? failure;
  final bool isSearching;

  FriendSearchFormState({
    required this.matchedUsers,
    required this.showErrorMessages,
    required this.isSearching,
    this.failure,
  });

  factory FriendSearchFormState.initial() => FriendSearchFormState(
        matchedUsers: List<UserData>.empty(),
        showErrorMessages: false,
        isSearching: false,
      );

  FriendSearchFormState copyWith({
    List<UserData>? matchedUsers,
    bool? showErrorMessages,
    FriendFailure? failure,
    bool? isSearching,
  }) {
    return FriendSearchFormState(
      matchedUsers: matchedUsers ?? this.matchedUsers,
      showErrorMessages: showErrorMessages ?? this.showErrorMessages,
      failure: failure ?? this.failure,
      isSearching: isSearching ?? this.isSearching,
    );
  }
}
