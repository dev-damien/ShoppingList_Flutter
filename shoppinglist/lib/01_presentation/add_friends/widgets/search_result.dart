import 'package:flutter/cupertino.dart';
import 'package:shoppinglist/03_domain/entities/user_data.dart';
import 'package:shoppinglist/core/mapper/image_mapper.dart';

class SearchResult extends StatelessWidget {
  final UserData user;
  const SearchResult({
    required this.user,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CupertinoListSection.insetGrouped(
      margin: EdgeInsets.all(10),
      topMargin: 0,
      children: [
        CupertinoListTile.notched(
          leadingSize: double.parse('42.0'),
          leading: Icon(
            ImageMapper.toIconData(user.imageId),
            size: 40,
          ),
          title: Text(user.name),
          subtitle: Text(user.id.value),
          trailing: CupertinoButton(
            child: Icon(
              CupertinoIcons.add_circled_solid,
              size: 30,
            ),
            onPressed: () {
              //TODO send friend request to this user

              print('send request');
            },
            padding: EdgeInsets.only(right: 0),
          ),
        ),
      ],
    );
  }
}
