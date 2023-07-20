// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:qr_flutter/qr_flutter.dart';

class AddFriendsBody extends StatelessWidget {
  User user;

  AddFriendsBody({
    Key? key,
    required this.user,
  }) : super(key: key);

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
        QrImageView(
          data: user.uid,
          version: QrVersions.auto,
          size: 320,
          gapless: false,
          backgroundColor: CupertinoColors.extraLightBackgroundGray,
          eyeStyle: QrEyeStyle(
              eyeShape: QrEyeShape.square, color: CupertinoColors.activeBlue),
        ),
        CupertinoButton.filled(
          onPressed: () {},
          child: Text("open scanner"),
        ),
        Image.asset('lib/assets/images/cydra.png')
        //TODO add list displaying matching account(s)
      ],
    );
  }
}
