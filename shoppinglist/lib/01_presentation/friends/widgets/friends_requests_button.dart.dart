import 'package:flutter/cupertino.dart';
import 'package:shoppinglist/01_presentation/friend_requests/friend_requests_page.dart';

class FriendsRequestsButton extends StatelessWidget {
  const FriendsRequestsButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      onPressed: () {
        Navigator.push(
          context,
          CupertinoPageRoute<Widget>(
            builder: (BuildContext context) {
              return FriendRequestsPage();
            },
          ),
        );
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Friend Requests'),
          SizedBox(
            width: 10,
          ),
        ],
      ),
    );
  }
}
