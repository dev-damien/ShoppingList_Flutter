import 'package:flutter/cupertino.dart';
import 'package:shoppinglist/01_presentation/account/account_page.dart';
import 'package:shoppinglist/01_presentation/friends/friends_page.dart';
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
            icon: Icon(CupertinoIcons.square_list),
            label: "Lists",
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.person_2),
            label: "Friends",
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.settings),
            label: "Settings",
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.profile_circled),
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
