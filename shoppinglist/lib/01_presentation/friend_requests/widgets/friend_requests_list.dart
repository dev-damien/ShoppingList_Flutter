import 'package:flutter/cupertino.dart';
import 'package:shoppinglist/01_presentation/friend_requests/widgets/friend_request_card.dart';
import 'package:shoppinglist/03_domain/entities/user_data.dart';

class FriendRequestsList extends StatelessWidget {
  final List<UserData> friendRequests;
  final BuildContext pageContext;
  const FriendRequestsList({
    super.key,
    required this.friendRequests,
    required this.pageContext,
  });

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
                final requesterData = friendRequests[index];
                return FriendRequestCard(
                  userData: requesterData,
                  pageContext: pageContext,
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
