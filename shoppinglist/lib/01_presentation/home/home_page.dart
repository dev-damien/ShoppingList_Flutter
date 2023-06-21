import 'package:flutter/cupertino.dart';
import 'package:shoppinglist/01_presentation/friends/friends_body.dart';
import 'package:shoppinglist/01_presentation/settings/settings_body.dart';
import 'package:shoppinglist/01_presentation/lists_overview/lists_body.dart';

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
        ],
      ),
      tabBuilder: (BuildContext context, int index) {
        return CupertinoTabView(
          builder: (BuildContext context) {
            switch (index) {
              case 0:
                return const CupertinoPageScaffold(
                  navigationBar: CupertinoNavigationBar(
                    middle: Text('Lists'),
                  ),
                  child: SafeArea(
                    child: ListsBody(),
                  ),
                );
              case 1:
                return const CupertinoPageScaffold(
                  navigationBar: CupertinoNavigationBar(
                    middle: Text('Friends'),
                  ),
                  child: SafeArea(
                    child: FriendsBody(),
                  ),
                );
              case 2:
                return CupertinoPageScaffold(
                  navigationBar: const CupertinoNavigationBar(
                    middle: Text('Settings'),
                  ),
                  child: SafeArea(
                    child: SettingsBody(),
                  ),
                );
              default:
                return const CupertinoPageScaffold(
                  navigationBar: CupertinoNavigationBar(
                    middle: Text('Lists'),
                  ),
                  child: SafeArea(
                    child: ListsBody(),
                  ),
                );
            }
          },
        );
      },
    );
  }
}
