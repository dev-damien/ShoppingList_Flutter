import 'package:flutter/cupertino.dart';
import 'package:shoppinglist/01_presentation/friends/friend_requests_page.dart';
import 'package:shoppinglist/01_presentation/util/number_notification.dart';

class FriendsRequestsButton extends StatelessWidget {
  const FriendsRequestsButton({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      onPressed: () {
        Navigator.push(
          context,
          CupertinoPageRoute<Widget>(
            builder: (BuildContext context) {
              return const FriendRequestsPage();
            },
          ),
        );
      },
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Friend Requests'),
          SizedBox(
            width: 10,
          ),
          NumberNotification(
            number: 4,
          ),
        ],
      ),
    );
  }
}
