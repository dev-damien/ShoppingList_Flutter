part of 'friend_search_form_bloc.dart';

class FriendSearchFormState {
  List<UserData> matchedUsers;
  final bool showErrorMessages;
  FriendFailure? failure;
  final bool isSearching;
  bool wasSearched;

  FriendSearchFormState({
    required this.wasSearched,
    required this.matchedUsers,
    required this.showErrorMessages,
    required this.isSearching,
    this.failure,
  });

  factory FriendSearchFormState.initial() => FriendSearchFormState(
        wasSearched: false,
        matchedUsers: List<UserData>.empty(),
        showErrorMessages: false,
        isSearching: false,
      );

  FriendSearchFormState copyWith({
    bool? wasSearched,
    List<UserData>? matchedUsers,
    bool? showErrorMessages,
    FriendFailure? failure,
    bool? isSearching,
  }) {
    return FriendSearchFormState(
      wasSearched: wasSearched ?? this.wasSearched,
      matchedUsers: matchedUsers ?? this.matchedUsers,
      showErrorMessages: showErrorMessages ?? this.showErrorMessages,
      failure: failure ?? this.failure,
      isSearching: isSearching ?? this.isSearching,
    );
  }
}
