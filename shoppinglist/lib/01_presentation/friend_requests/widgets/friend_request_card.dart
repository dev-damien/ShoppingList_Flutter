import 'package:flutter/cupertino.dart';
import 'package:shoppinglist/03_domain/entities/user_data.dart';
import 'package:shoppinglist/core/mapper/image_mapper.dart';

class FriendRequestCard extends StatelessWidget {
  final UserData userData;

  const FriendRequestCard({
    Key? key,
    required this.userData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoListTile.notched(
      leading: SizedBox(
        width: double.infinity,
        height: double.infinity,
        //TODO set selected icon of friend
        child: Icon(
          ImageMapper.toIconData(userData.imageId),
          size: 30,
        ),
      ),
      title: Text(
        userData.name,
      ),
      trailing: Row(
        children: [
          CupertinoButton(
            child: Column(
              children: [
                Icon(
                  CupertinoIcons.clear_circled_solid,
                  color: CupertinoColors.destructiveRed,
                  size: 30,
                ),
                Text(
                  'Decline',
                  style: TextStyle(
                    color: CupertinoColors.destructiveRed,
                  ),
                ),
              ],
            ),
            onPressed: () {
              //TODO implement decline friend request
              print('friend request of ${userData.name} declined');
            },
          ),
          CupertinoButton(
            child: Column(
              children: [
                Icon(
                  CupertinoIcons.check_mark_circled_solid,
                  color: CupertinoColors.activeGreen,
                  size: 30,
                ),
                Text(
                  'Accept',
                  style: TextStyle(
                    color: CupertinoColors.activeGreen,
                  ),
                )
              ],
            ),
            onPressed: () {
              //TODO implement accept friend request
              print('friend request of ${userData.name} accepted');
            },
          ),
        ],
      ),
    );
  }
}
