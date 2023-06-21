import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoppinglist/01_presentation/home/home_page.dart';
import 'package:shoppinglist/01_presentation/lists_overview/lists_body.dart';
import 'package:shoppinglist/02_application/auth/authbloc/auth_bloc.dart';

class SettingsBody extends StatelessWidget {
  SettingsBody({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: Column(
        children: [
          //#### APPEARENCE ############################################################
          CupertinoListSection.insetGrouped(
            header: const Text('Appearence'),
            children: <CupertinoListTile>[
              CupertinoListTile.notched(
                title: const Text('Use system theme'),
                leading: const SizedBox(
                  width: double.infinity,
                  height: double.infinity,
                  child: Icon(CupertinoIcons.arrow_2_circlepath),
                ),
                trailing: CupertinoSwitch(
                  onChanged: (bool value) {},
                  value: false,
                ),
              ),
              CupertinoListTile.notched(
                title: const Text('Darkmode'),
                leading: const SizedBox(
                  width: double.infinity,
                  height: double.infinity,
                  child: Icon(CupertinoIcons.moon_zzz),
                ),
                trailing: CupertinoSwitch(
                  onChanged: (bool value) {},
                  value: false,
                ),
                onTap: () => Navigator.of(context).push(
                  CupertinoPageRoute<void>(
                    builder: (BuildContext context) {
                      return const HomePage();
                    },
                  ),
                ),
              ),
            ],
          ),
          //### APPEARENCE #############################################################

          //### LANGUAGE #############################################################
          CupertinoListSection.insetGrouped(
            header: const Text('Language'),
            children: const <CupertinoListTile>[
              CupertinoListTile.notched(
                title: Text('App language'),
                leading: SizedBox(
                  width: double.infinity,
                  height: double.infinity,
                  child: Icon(CupertinoIcons.globe),
                ),
                additionalInfo: Text('Not available'),
              ),
            ],
          ),
          //### LANGUAGE #############################################################

          //### ACCOUNT #############################################################
          Expanded(
            child: CupertinoListSection.insetGrouped(
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
                    BlocProvider.of<AuthBloc>(context)
                        .add(SignOutPressedEvent())
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
            ),
          ),
          //### ACCOUNT #############################################################
        ],
      ),
    );
  }
}
