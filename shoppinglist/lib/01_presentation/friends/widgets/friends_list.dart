import 'package:flutter/cupertino.dart';
import 'package:shoppinglist/03_domain/entities/friend.dart';

import 'friend_card.dart';

class FriendsList extends StatelessWidget {
  final List<Friend> friends;

  const FriendsList({required this.friends, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
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
