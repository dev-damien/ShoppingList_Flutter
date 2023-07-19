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
        Padding(
          padding: const EdgeInsets.only(
            left: 10,
            right: 10,
          ),
          child: CupertinoSearchTextField(),
        ),
        //TODO add list displaying matching account(s)
      ],
    );
  }
}
