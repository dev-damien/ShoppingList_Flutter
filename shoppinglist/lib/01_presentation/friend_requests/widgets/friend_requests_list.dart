import 'package:flutter/cupertino.dart';
import 'package:shoppinglist/01_presentation/friend_requests/widgets/friend_request_card.dart';
import 'package:shoppinglist/03_domain/entities/friend.dart';

class FriendRequestsList extends StatelessWidget {
  List<Friend> friendRequests;
  FriendRequestsList({super.key, required this.friendRequests});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      child: CupertinoScrollbar(
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: CupertinoListSection(
            topMargin: 0,
            margin: EdgeInsets.all(0),
            children: List.generate(
              friendRequests.length,
              (index) {
                final friend = friendRequests[index];
                return FriendRequestCard(
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
