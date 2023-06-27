import 'package:flutter/cupertino.dart';
import 'package:shoppinglist/01_presentation/create_list/widgets/added_friend_card.dart';
import 'package:shoppinglist/01_presentation/util/number_notification.dart';
import 'package:shoppinglist/03_domain/entities/friend.dart';
import 'package:shoppinglist/03_domain/entities/id.dart';

import 'friend_card.dart';

class FriendsList extends StatelessWidget {
  List<Friend> friends = List.of(
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
    ],
  );

  FriendsList({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      //TODO UI choice either limit size or not
      // height: 200,
      child: CupertinoScrollbar(
        child: SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          child: CupertinoListSection.insetGrouped(
            topMargin: 0,
            margin: EdgeInsets.all(0),
            children: List.generate(
              friends.length,
              (index) {
                final friend = friends[index];
                return FriendCard(
                  friend: friend,
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
