import 'package:flutter/cupertino.dart';
import 'package:shoppinglist/03_domain/entities/friend.dart';

class FriendCard extends StatelessWidget {
  final Friend friend;

  const FriendCard({
    Key? key,
    required this.friend,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () {
        //TODO remove print and open option menu
        print("long press down on ${friend.nickname}");
      },
      child: CupertinoListTile.notched(
        leading: const SizedBox(
          width: double.infinity,
          height: double.infinity,
          //TODO set selected icon of friend
          child: Icon(CupertinoIcons.person),
        ),
        title: Text(
          friend.nickname,
        ),
        trailing: CupertinoButton(
          child: Icon(
            CupertinoIcons.ellipsis,
          ),
          onPressed: () {},
        ),
      ),
    );
  }
}
