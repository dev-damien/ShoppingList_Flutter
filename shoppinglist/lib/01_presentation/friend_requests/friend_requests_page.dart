import 'package:flutter/cupertino.dart';
import 'package:shoppinglist/01_presentation/friend_requests/widgets/friend_requests_body.dart';

class FriendRequestsPage extends StatelessWidget {
  const FriendRequestsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        leading: CupertinoNavigationBarBackButton(
          onPressed: () => Navigator.pop(context),
          previousPageTitle: 'Friends',
        ),
        middle: const Text(
          'Friend requests',
        ),
      ),
      child: SafeArea(
        child: FriendRequestsBody(),
      ),
    );
  }
}
