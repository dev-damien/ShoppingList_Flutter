import 'package:flutter/cupertino.dart';
import 'package:shoppinglist/01_presentation/account/account_page.dart';
import 'package:shoppinglist/01_presentation/friends/friends_page.dart';
import 'package:shoppinglist/01_presentation/home/widgets/TabIconWithNotification.dart';
import 'package:shoppinglist/01_presentation/lists_overview/lists_overview_page.dart';
import 'package:shoppinglist/01_presentation/settings/settings_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: TabIconWithNotification(
              iconData: CupertinoIcons.square_list,
              notificationCount: 0,
            ),
            label: "Lists",
          ),
          BottomNavigationBarItem(
            //icon: Icon(CupertinoIcons.person_2),
            icon: TabIconWithNotification(
              iconData: CupertinoIcons.person_2,
              notificationCount: 1,
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
}
