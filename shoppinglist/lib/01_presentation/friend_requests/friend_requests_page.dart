import 'package:flutter/cupertino.dart';
import 'package:shoppinglist/01_presentation/friend_requests/widgets/friend_requests_body.dart';
import 'package:shoppinglist/01_presentation/util/number_notification.dart';
import 'package:shoppinglist/03_domain/entities/friend.dart';
import 'package:shoppinglist/03_domain/entities/id.dart';

class FriendRequestsPage extends StatelessWidget {
  FriendRequestsPage({super.key});

  List<Friend> friendRequests = List.of(
    [
      Friend(
        id: UniqueID.fromUniqueString("uniqueID"),
        nickname: "Nick",
        imageId: "imageId111",
      ),
      Friend(
        id: UniqueID.fromUniqueString("uniqueID2"),
        nickname: "Ken Thompson",
        imageId: "imageId222",
      ),
      Friend(
        id: UniqueID.fromUniqueString("uniqueID"),
        nickname: "Nick",
        imageId: "imageId111",
      ),
      Friend(
        id: UniqueID.fromUniqueString("uniqueID2"),
        nickname: "Ken Thompson",
        imageId: "imageId222",
      ),
      Friend(
        id: UniqueID.fromUniqueString("uniqueID2"),
        nickname: "Ken Thompson",
        imageId: "imageId222",
      ),
      Friend(
        id: UniqueID.fromUniqueString("uniqueID"),
        nickname: "Nick",
        imageId: "imageId111",
      ),
      Friend(
        id: UniqueID.fromUniqueString("uniqueID2"),
        nickname: "Ken Thompson",
        imageId: "imageId222",
      ),
      Friend(
        id: UniqueID.fromUniqueString("uniqueID"),
        nickname: "Nick",
        imageId: "imageId111",
      ),
      Friend(
        id: UniqueID.fromUniqueString("uniqueID2"),
        nickname: "Ken Thompson",
        imageId: "imageId222",
      ),
      Friend(
        id: UniqueID.fromUniqueString("uniqueID"),
        nickname: "Nick",
        imageId: "imageId111",
      ),
      Friend(
        id: UniqueID.fromUniqueString("uniqueID2"),
        nickname: "Ken Thompson",
        imageId: "imageId222",
      ),
      Friend(
        id: UniqueID.fromUniqueString("uniqueID2"),
        nickname: "Ken Thompson",
        imageId: "imageId222",
      ),
      Friend(
        id: UniqueID.fromUniqueString("uniqueID"),
        nickname: "Nick",
        imageId: "imageId111",
      ),
      Friend(
        id: UniqueID.fromUniqueString("uniqueID2"),
        nickname: "Ken Thompson",
        imageId: "imageId222",
      ),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        leading: CupertinoNavigationBarBackButton(
          onPressed: () => Navigator.pop(context),
          previousPageTitle: 'Friends',
        ),
        middle: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Row(
            children: [
              const Text(
                'Friend requests',
              ),
              SizedBox(
                width: 5,
              ),
              NumberNotification(
                number: friendRequests.length,
              )
            ],
          ),
        ),
      ),
      child: SafeArea(
        child: FriendRequestsBody(
          friendRequests: friendRequests,
        ),
      ),
    );
  }
}
