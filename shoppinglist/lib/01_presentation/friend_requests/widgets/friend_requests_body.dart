import 'package:flutter/cupertino.dart';
import 'package:shoppinglist/01_presentation/friend_requests/widgets/friend_requests_list.dart';
import 'package:shoppinglist/03_domain/entities/friend.dart';

class FriendRequestsBody extends StatelessWidget {
  List<Friend> friendRequests;
  FriendRequestsBody({super.key, required this.friendRequests});

  @override
  Widget build(BuildContext context) {
    return FriendRequestsList(
      friendRequests: friendRequests,
    );
  }
}
