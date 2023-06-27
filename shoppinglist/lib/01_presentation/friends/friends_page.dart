import 'package:flutter/cupertino.dart';
import 'package:shoppinglist/01_presentation/friends/widgets/friends_body.dart';

class FriendsPage extends StatelessWidget {
  const FriendsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;

    return CupertinoPageScaffold(
      backgroundColor:
          !isDark ? CupertinoColors.secondarySystemBackground : null,
      navigationBar: CupertinoNavigationBar(
        middle: Text("Friends"),
        trailing: Icon(CupertinoIcons.person_add),
      ),
      child: SafeArea(
        child: FriendsBody(),
      ),
    );
  }
}
