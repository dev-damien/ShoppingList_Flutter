import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoppinglist/01_presentation/friend_requests/widgets/friend_requests_list.dart';
import 'package:shoppinglist/02_application/friend_requests/observer/friend_requests_observer_bloc.dart';
import 'package:shoppinglist/02_application/user/observer/user_observer_bloc.dart';
import 'package:shoppinglist/03_domain/entities/friend.dart';
import 'package:shoppinglist/03_domain/entities/user_data.dart';
import 'package:shoppinglist/core/failures/user_failures.dart';
import 'package:shoppinglist/injection.dart';

class FriendRequestsBody extends StatelessWidget {
  const FriendRequestsBody({
    super.key,
  });

  String mapFailureMessage(UserFailure failure) {
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
    final friendRequestsObserverBloc = sl<FriendRequestsObserverBloc>()
      ..add(
        ObserveAllFriendRequestsEvent(),
      );

    return MultiBlocProvider(
      providers: [
        BlocProvider<FriendRequestsObserverBloc>(
          create: (context) => friendRequestsObserverBloc,
        ),
      ],
      child:
          BlocBuilder<FriendRequestsObserverBloc, FriendRequestsObserverState>(
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
                  state.userFailure,
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
      ),
    );
  }
}
