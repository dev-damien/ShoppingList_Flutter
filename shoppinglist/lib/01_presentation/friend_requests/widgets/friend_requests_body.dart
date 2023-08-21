import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoppinglist/01_presentation/friend_requests/widgets/friend_requests_list.dart';
import 'package:shoppinglist/02_application/friend_requests/observer/friend_requests_observer_bloc.dart';
import 'package:shoppinglist/core/failures/friend_failures.dart';

class FriendRequestsBody extends StatelessWidget {
  const FriendRequestsBody({
    super.key,
  });

  String mapFailureMessage(FriendFailure failure) {
    switch (failure.runtimeType) {
      case InsufficientPermissions:
        return "Your permissions are insufficient.";
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
    return BlocBuilder<FriendRequestsObserverBloc, FriendRequestsObserverState>(
      builder: (context, state) {
        if (state is FriendRequestsObserverInitial) {
          return Container();
        }
        if (state is FriendRequestsObserverLoading) {
          return const Center(
            child: CupertinoActivityIndicator(),
          );
        }
        if (state is FriendRequestsObserverFailure) {
          return Center(
            child: Text(
              mapFailureMessage(
                state.friendFailure,
              ),
            ),
          );
        }
        if (state is FriendRequestsObserverSuccess) {
          final friendRequests = state.friendRequests;
          if (friendRequests.isEmpty) {
            // user has no requests
            return const Center(
              child: Text('You have no friend requests'),
            );
          }
          // user has at least one valid request
          return FriendRequestsList(
            friendRequests: friendRequests,
          );
        }
        return Container();
      },
    );
  }
}
