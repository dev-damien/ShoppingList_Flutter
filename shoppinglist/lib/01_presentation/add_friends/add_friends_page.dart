import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:shoppinglist/01_presentation/add_friends/widgets/add_friends_body.dart';
import 'package:shoppinglist/02_application/friend_requests/controller/friend_request_controller_bloc.dart';
import 'package:shoppinglist/injection.dart';

class AddFriendsPage extends StatelessWidget {
  const AddFriendsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    User user = FirebaseAuth.instance.currentUser!;

    return CupertinoPageScaffold(
      backgroundColor:
          !isDark ? CupertinoColors.secondarySystemBackground : null,
      navigationBar: CupertinoNavigationBar(
        leading: CupertinoNavigationBarBackButton(
          onPressed: () => Navigator.pop(context),
          previousPageTitle: "Friends",
        ),
        middle: const Text('Add Friends'),
      ),
      child: Container(
        height: double.infinity,
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: SafeArea(
            child: AddFriendsBody(
              user: user,
            ),
          ),
        ),
      ),
    );
  }
}
