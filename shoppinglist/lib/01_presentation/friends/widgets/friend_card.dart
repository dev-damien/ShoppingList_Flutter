import 'package:flutter/cupertino.dart';
import 'package:shoppinglist/03_domain/entities/friend.dart';
import 'package:shoppinglist/core/mapper/image_mapper.dart';

class FriendCard extends StatelessWidget {
  final Friend friend;

  const FriendCard({
    Key? key,
    required this.friend,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // whole tile triggers the event, without only widgets like icon or title
      behavior: HitTestBehavior.translucent,
      onLongPress: () {
        _showFriendActionSheet(context);
      },
      child: CupertinoListTile.notched(
        leading: SizedBox(
          width: double.infinity,
          height: double.infinity,
          //TODO set selected icon of friend
          child: Icon(
            ImageMapper.toIconData(friend.imageId),
            size: 30,
          ),
        ),
        title: Text(
          friend.nickname,
        ),
        subtitle: Text(
          friend.id.value,
        ),
        trailing: CupertinoButton(
          padding: EdgeInsets.zero,
          child: Icon(
            CupertinoIcons.ellipsis,
          ),
          onPressed: () {
            _showFriendActionSheet(context);
          },
        ),
      ),
    );
  }

  void _showFriendActionSheet(BuildContext context) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => CupertinoActionSheet(
        title: Text('Options for ${friend.nickname}'),
        //message: const Text('Message'),
        actions: <CupertinoActionSheetAction>[
          CupertinoActionSheetAction(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Change nickname'),
          ),
          CupertinoActionSheetAction(
            isDestructiveAction: true,
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Remove as friend'),
          ),
        ],
      ),
    );
  }
}
