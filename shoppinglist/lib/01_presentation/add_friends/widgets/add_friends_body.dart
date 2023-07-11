import 'package:flutter/cupertino.dart';

class AddFriendsBody extends StatelessWidget {
  const AddFriendsBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 10,
        ),
        CupertinoSearchTextField(),
        //TODO add list displaying matching account(s)
      ],
    );
  }
}
