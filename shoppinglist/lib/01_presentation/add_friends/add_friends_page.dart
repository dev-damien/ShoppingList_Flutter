import 'package:flutter/cupertino.dart';
import 'package:shoppinglist/01_presentation/add_friends/widgets/add_friends_body.dart';
import 'package:shoppinglist/01_presentation/create_list/widgets/create_list_body.dart';

class AddFriendsPage extends StatelessWidget {
  const AddFriendsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;

    return CupertinoPageScaffold(
      backgroundColor:
          !isDark ? CupertinoColors.secondarySystemBackground : null,
      navigationBar: CupertinoNavigationBar(
        leading: CupertinoNavigationBarBackButton(
          onPressed: () => Navigator.pop(context),
          previousPageTitle: "Friends",
        ),
        middle: const Text('Add Friends'),
      ),
      child: Container(
        height: double.infinity,
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: const SafeArea(
            child: AddFriendsBody(),
          ),
        ),
      ),
    );
  }
}
