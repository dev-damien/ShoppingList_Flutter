import 'package:flutter/cupertino.dart';

class ProfileOverview extends StatelessWidget {
  const ProfileOverview({super.key});

  @override
  Widget build(BuildContext context) {
    //todo get real user data
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          CupertinoIcons.profile_circled,
          size: 80,
        ),
        //todo replace with real data
        Row(
          children: [
            Text("Name: "),
            Text("nameOfUser"),
          ],
          mainAxisAlignment: MainAxisAlignment.center,
        ),
        //todo replace with real data
        Row(
          children: [
            Text("ID: "),
            Text("ociwnhepifps0fnwjio"),
          ],
          mainAxisAlignment: MainAxisAlignment.center,
        ),
      ],
    );
  }
}
