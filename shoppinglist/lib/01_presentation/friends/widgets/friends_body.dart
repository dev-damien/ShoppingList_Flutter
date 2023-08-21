import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoppinglist/01_presentation/friends/widgets/friends_list.dart';
import 'package:shoppinglist/01_presentation/friends/widgets/friends_requests_button.dart.dart';
import 'package:shoppinglist/02_application/friends/observer/friends_observer_bloc.dart';
import 'package:shoppinglist/core/failures/friend_failures.dart';
import 'package:shoppinglist/injection.dart';

class FriendsBody extends StatelessWidget {
  const FriendsBody({super.key});

  String mapFailureMessage(FriendFailure failure) {
    switch (failure.runtimeType) {
      case InsufficientPermissions:
        return "Your permissions are insufficient.";
      case AlreadyFriends:
        return "You are already friends with this user.";
      case UserNotFound:
        return "No user with this ID has been found.";
      case UnexpectedFailure:
        return "An unexpected error occured. Try to restart the application.";
      case UnexpectedFailureFirebase:
        return "An unexpected error occured. This should not happen.";
      default:
        return "Something went wrong";
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FriendsObserverBloc, FriendsObserverState>(
      builder: (context, state) {
        if (state is FriendsObserverInitial) {
          return Container();
        }
        if (state is FriendsObserverLoading) {
          return const Center(child: CupertinoActivityIndicator());
        }
        if (state is FriendsObserverFailure) {
          return Center(
            child: Text(
              mapFailureMessage(
                state.friendFailure,
              ),
            ),
          );
        }
        if (state is FriendsObserverSuccess) {
          if (state.friends.isEmpty) {
            // user has no friends
            return Padding(
              padding: const EdgeInsets.only(
                top: 20,
                left: 10,
                right: 10,
              ),
              child: const Center(
                child: Text('You have no friends added yet'),
              ),
            );
          }
          return Column(
            children: [
              FriendsRequestsButton(),
              Padding(
                padding: const EdgeInsets.only(
                  left: 15,
                  right: 15,
                ),
                child: FriendsList(
                  friends: state.friends,
                ),
              ),
            ],
          );
        }
        return Container();
      },
    );
  }
}
