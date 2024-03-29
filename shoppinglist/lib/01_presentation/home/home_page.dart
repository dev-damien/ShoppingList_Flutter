import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoppinglist/01_presentation/account/account_page.dart';
import 'package:shoppinglist/01_presentation/friends/friends_page.dart';
import 'package:shoppinglist/01_presentation/home/widgets/tabIconWithNotification.dart';
import 'package:shoppinglist/01_presentation/lists_overview/lists_overview_page.dart';
import 'package:shoppinglist/01_presentation/settings/settings_page.dart';
import 'package:shoppinglist/02_application/friend_requests/observer/friend_requests_observer_bloc.dart';
import 'package:shoppinglist/core/failures/friend_failures.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

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
          return const CupertinoActivityIndicator();
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
          return CupertinoTabScaffold(
            tabBar: CupertinoTabBar(
              items: <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: TabIconWithNotification(
                    iconData: CupertinoIcons.square_list,
                    notificationCount: 0,
                  ),
                  label: "Lists",
                ),
                BottomNavigationBarItem(
                  icon: TabIconWithNotification(
                    iconData: CupertinoIcons.person_2,
                    notificationCount: state.friendRequests.length,
                  ),
                  label: "Friends",
                ),
                BottomNavigationBarItem(
                  icon: TabIconWithNotification(
                    iconData: CupertinoIcons.settings,
                    notificationCount: 0,
                  ),
                  label: "Settings",
                ),
                BottomNavigationBarItem(
                  icon: TabIconWithNotification(
                    iconData: CupertinoIcons.profile_circled,
                    notificationCount: 0,
                  ),
                  label: "Account",
                ),
              ],
            ),
            tabBuilder: (BuildContext context, int index) {
              return CupertinoTabView(
                builder: (BuildContext context) {
                  switch (index) {
                    case 0:
                      return const ListsOverviewPage();
                    case 1:
                      return const FriendsPage();
                    case 2:
                      return const SettingsPage();
                    case 3:
                      return const AccountPage();
                    default:
                      return const ListsOverviewPage();
                  }
                },
              );
            },
          );
        }
        return Container();
      },
    );
  }
}
