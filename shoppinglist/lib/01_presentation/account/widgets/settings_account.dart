import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoppinglist/02_application/auth/authbloc/auth_bloc.dart';

class SettingsAccount extends StatelessWidget {
  const SettingsAccount({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoListSection.insetGrouped(
      children: <CupertinoListTile>[
        CupertinoListTile.notched(
          title: const Text('Change profile picture'),
          leading: const SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: Icon(CupertinoIcons.profile_circled),
          ),
          trailing: const CupertinoListTileChevron(),
          onTap: () {
            //todo open page to change profile picture
            print("change profile picture clicked");
          },
        ),
        CupertinoListTile.notched(
          title: const Text('Change name'),
          leading: const SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: Icon(CupertinoIcons.pencil),
          ),
          trailing: const CupertinoListTileChevron(),
          onTap: () {
            //todo open change name page/dialog
            print("change name clicked");
          },
        ),
        CupertinoListTile.notched(
          title: const Text('Reset password'),
          leading: const SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: Icon(CupertinoIcons.mail),
          ),
          onTap: () {
            //todo reset password with mail
            print("reset password clicked");
          },
        ),
        CupertinoListTile.notched(
          title: const Text('Logout'),
          leading: const SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: Icon(Icons.exit_to_app),
          ),
          onTap: () {
            BlocProvider.of<AuthBloc>(context).add(
              SignOutPressedEvent(),
            );
          },
        ),
        CupertinoListTile.notched(
          title: const Text('Delete account'),
          leading: const SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: Icon(CupertinoIcons.delete),
          ),
          onTap: () {
            //todo delete account
            print("delete account clicked");
          },
        ),
      ],
    );
  }
}
