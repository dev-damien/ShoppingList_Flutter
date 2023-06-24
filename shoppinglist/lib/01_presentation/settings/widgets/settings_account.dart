import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoppinglist/01_presentation/lists_overview/widgets/lists_body.dart';
import 'package:shoppinglist/02_application/auth/authbloc/auth_bloc.dart';

class SettingsAccount extends StatelessWidget {
  const SettingsAccount({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoListSection.insetGrouped(
      header: const Text('Account'),
      children: <CupertinoListTile>[
        CupertinoListTile.notched(
          title: const Text('Change profile picture'),
          leading: const SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: Icon(CupertinoIcons
                .profile_circled), //todo set currently selected profile picture
          ),
          trailing: const CupertinoListTileChevron(),
          onTap: () => Navigator.of(context).push(
            CupertinoPageRoute<void>(
              builder: (BuildContext context) {
                return const ListsBody();
              },
            ),
          ),
        ),
        CupertinoListTile.notched(
          title: const Text('Reset password'),
          trailing: const CupertinoListTileChevron(),
          leading: const SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: Icon(CupertinoIcons.mail),
          ),
          onTap: () => {
            //todo reset password with mail
          },
        ),
        CupertinoListTile.notched(
          title: const Text('Logout'),
          trailing: const CupertinoListTileChevron(),
          leading: const SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: Icon(Icons.exit_to_app),
          ),
          onTap: () => {
            BlocProvider.of<AuthBloc>(context).add(
              SignOutPressedEvent(),
            ),
          },
        ),
        CupertinoListTile.notched(
          title: const Text('Delete account'),
          trailing: const CupertinoListTileChevron(),
          leading: const SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: Icon(CupertinoIcons.delete),
          ),
          onTap: () => {
            //todo delete account
          },
        ),
      ],
    );
  }
}
