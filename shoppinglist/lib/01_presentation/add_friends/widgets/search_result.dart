import 'package:flutter/cupertino.dart';

class SearchResult extends StatelessWidget {
  const SearchResult({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoListSection.insetGrouped(
      margin: EdgeInsets.all(10),
      topMargin: 0,
      children: [
        CupertinoListTile.notched(
          leadingSize: double.parse('42.0'),
          leading: Icon(
            CupertinoIcons.profile_circled,
            size: 40,
          ),
          //TODO use real username
          title: Text('todoRealUserName'),
          trailing: CupertinoButton(
            //TODO use real icon
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
