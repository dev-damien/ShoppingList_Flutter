import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoppinglist/01_presentation/util/icon_selection_page.dart';
import 'package:shoppinglist/02_application/auth/authbloc/auth_bloc.dart';
import 'package:shoppinglist/02_application/auth/password/password_reset_form_bloc.dart';
import 'package:shoppinglist/02_application/user/controller/user_controller_bloc.dart';
import 'package:shoppinglist/03_domain/entities/user_data.dart';
import 'package:shoppinglist/core/failures/reset_password_failures.dart';
import 'package:shoppinglist/core/mapper/image_mapper.dart';
import 'package:shoppinglist/injection.dart';

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
            _showResetPasswordDialog(context);
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

  Future<void> _showResetPasswordDialog(
    BuildContext context,
  ) {
    final passwordResetFormBloc = sl<PasswordResetFormBloc>()
      ..add(SendPasswordResetMailEvent());

    String codeInput = '';
    String passwordInput = '';
    return showCupertinoDialog(
      context: context,
      builder: (BuildContext context) {
        return BlocProvider(
          create: (context) => passwordResetFormBloc,
          child: BlocConsumer<PasswordResetFormBloc, PasswordResetFormState>(
            listener: (context, state) {},
            builder: (context, state) {
              return CupertinoAlertDialog(
                title: const Text('Reset your password'),
                content: Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Builder(
                    builder: (context) {
                      if (state is PasswordResetFormInitial) {
                        return const Column(
                          children: [
                            Text('Sending reset mail ...'),
                            SizedBox(
                              height: 10,
                            ),
                            CupertinoActivityIndicator(),
                          ],
                        );
                      }
                      if (state is PasswordResetFormMailSent) {
                        return Column(
                          children: [
                            const Text(
                              'Please enter the verification code you received in your email, along with your new password.',
                              style: TextStyle(fontSize: 14),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Code',
                                  style: TextStyle(fontSize: 16),
                                ),
                                CupertinoTextField(
                                  placeholder: 'Enter code',
                                  onChanged: (value) {
                                    codeInput = value;
                                  },
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'New password',
                                  style: TextStyle(fontSize: 16),
                                ),
                                CupertinoTextField(
                                  placeholder: 'Enter new password',
                                  onChanged: (value) {
                                    passwordInput = value;
                                  },
                                ),
                              ],
                            ),
                          ],
                        );
                      }
                      if (state is PasswordResetFormInProgress) {
                        return const Column(
                          children: [
                            Text('Validating code and password. Please wait.'),
                            SizedBox(
                              height: 10,
                            ),
                            CupertinoActivityIndicator(),
                          ],
                        );
                      }
                      if (state is PasswordResetFormFailure) {
                        return Text(
                            'Error occured:\n${mapFailureMessage(state.resetPasswordFailure)}');
                      }
                      if (state is PasswordResetFormSuccess) {
                        return const Text(
                            'Password changed successfully. You\'re all set!');
                      }
                      return const Text('ERROR ');
                    },
                  ),
                ),
                actions: (state is PasswordResetFormMailSent)
                    ? <CupertinoDialogAction>[
                        CupertinoDialogAction(
                          child: const Text('Cancel'),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                        CupertinoDialogAction(
                          child: const Text('Confirm'),
                          onPressed: () {
                            passwordResetFormBloc.add(
                              ResetPasswordEvent(
                                code: codeInput,
                                newPassword: passwordInput,
                              ),
                            );
                          },
                        ),
                      ]
                    : (state is PasswordResetFormFailure ||
                            state is PasswordResetFormSuccess)
                        ? <CupertinoDialogAction>[
                            CupertinoDialogAction(
                              child: const Text('Okay'),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ]
                        : [],
              );
            },
          ),
        );
      },
    );
  }

  String mapFailureMessage(ResetPasswordFailure failure) {
    switch (failure.runtimeType) {
      case CodeInvalid:
        return "The entered code is invalid";
      case CodeExpired:
        return "Your code has expired.";
      case UserNotFound:
        return "No user with this ID has been found.";
      case WeakPassword:
        return "Your new password is too weak, it needs at least six digits.";
      case UnexpectedFailure:
        return "An unexpected error occured. Try to restart the application.";
      case UnexpectedFailureFirebase:
        return "An unexpected error occured. This should not happen.";
      default:
        return "Something went wrong";
    }
  }

  //TODO user currentuser. reauthenticate with credientials before deleteing to avaoid errors
}
