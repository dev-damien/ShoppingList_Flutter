import 'package:flutter/cupertino.dart';
import 'package:shoppinglist/03_domain/entities/friend.dart';
import 'package:shoppinglist/core/mapper/image_mapper.dart';

class AddedFriendCard extends StatelessWidget {
  final Friend friend;
  final bool isMember;

  const AddedFriendCard({
    Key? key,
    required this.friend,
    required this.isMember,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoListTile.notched(
      leading: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Icon(ImageMapper.toIconData(friend.imageId)),
      ),
      title: Text(
        friend.nickname,
      ),
      subtitle: Text(friend.id.value),
    );
  }
}
