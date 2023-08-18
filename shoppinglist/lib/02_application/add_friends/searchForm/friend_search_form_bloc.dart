import 'package:bloc/bloc.dart';
import 'package:shoppinglist/03_domain/entities/user_data.dart';
import 'package:shoppinglist/03_domain/usecases/friend_usecases.dart';
import 'package:shoppinglist/core/failures/friend_failures.dart';

part 'friend_search_form_event.dart';
part 'friend_search_form_state.dart';

class FriendSearchFormBloc
    extends Bloc<FriendSearchFormEvent, FriendSearchFormState> {
  final FriendUsecases friendUsecases;

  FriendSearchFormBloc({required this.friendUsecases})
      : super(FriendSearchFormState.initial()) {
    on<SearchUserEvent>((event, emit) async {
      print('search user event received'); //TODO remove debug print
      emit(state.copyWith(isSearching: true));

      final searchResultsOrFailure =
          await friendUsecases.searchUsers(event.searchString);
      searchResultsOrFailure.fold(
        (failure) {
          print('search friend failure occured'); //TODO remove debug print
          emit(
            state.copyWith(
              isSearching: false,
              showErrorMessages: true,
              failure: failure,
            ),
          );
        },
        (searchResults) {
          print('search friend success'); //TODO remove debug print
          emit(
            state.copyWith(
              wasSearched: true,
              matchedUsers: searchResults,
              isSearching: false,
              showErrorMessages: false,
            ),
          );
        },
      );
    });
  }
}
