import 'package:flutter/cupertino.dart';
import 'package:shoppinglist/01_presentation/friends/widgets/friend_requests_body.dart';

class FriendRequestsPage extends StatelessWidget {
  const FriendRequestsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        leading: CupertinoNavigationBarBackButton(
          onPressed: () => Navigator.pop(context),
        ),
        middle: const Text('Friend requests'),
      ),
      child: const SafeArea(
        child: FriendRequestsBody(),
      ),
    );
  }
}
