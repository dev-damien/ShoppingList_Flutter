import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoppinglist/01_presentation/util/icon_selection_page.dart';
import 'package:shoppinglist/02_application/auth/authbloc/auth_bloc.dart';
import 'package:shoppinglist/02_application/user/controller/user_controller_bloc.dart';
import 'package:shoppinglist/03_domain/entities/user_data.dart';
import 'package:shoppinglist/core/mapper/image_mapper.dart';

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
            _showIconSelectionDialog(context);
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
            _showChangeNameDialog(context, null);
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

  void _showIconSelectionDialog(BuildContext context) async {
    final Map<String, IconData> iconDataMap = ImageMapper.string2iconDataUser
        .map((key, value) => MapEntry(key, value['default']!));
    await showCupertinoDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return IconSelectionPage(iconDataMap: iconDataMap);
      },
    ).then((imageValue) {
      if (imageValue != null) {
        BlocProvider.of<UserControllerBloc>(context).add(
          UpdateUserEvent(
            userData: UserData.empty().copyWith(imageId: imageValue),
          ),
        );
      }
    });
  }

  Future<void> _showChangeNameDialog(
    BuildContext context,
    String? currentName,
  ) {
    String newName = currentName ?? "";
    //todo Initialize with the current name

    return showCupertinoDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: const Text('Enter your new name'),
          content: Padding(
            padding: const EdgeInsets.only(top: 8),
            child: CupertinoTextField(
              placeholder: 'Enter name',
              onChanged: (value) {
                newName = value;
              },
            ),
          ),
          actions: <CupertinoDialogAction>[
            CupertinoDialogAction(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            CupertinoDialogAction(
              child: const Text('Safe'),
              onPressed: () {
                BlocProvider.of<UserControllerBloc>(context).add(
                  UpdateUserEvent(
                    userData: UserData.empty().copyWith(name: newName),
                  ),
                );
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  //TODO user currentuser. reauthenticate with credientials before deleteing to avaoid errors
}
