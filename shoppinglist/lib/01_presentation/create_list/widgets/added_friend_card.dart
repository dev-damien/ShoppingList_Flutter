import 'package:flutter/cupertino.dart';
import 'package:shoppinglist/03_domain/entities/friend.dart';

class AddedFriendCard extends StatelessWidget {
  final Friend friend;

  const AddedFriendCard({
    Key? key,
    required this.friend,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoListTile.notched(
      leading: const SizedBox(
        width: double.infinity,
        height: double.infinity,
        //TODO set selected icon of friend
        child: Icon(CupertinoIcons.person),
      ),
      title: Text(
        friend.nickname,
      ),
    );
  }
}
