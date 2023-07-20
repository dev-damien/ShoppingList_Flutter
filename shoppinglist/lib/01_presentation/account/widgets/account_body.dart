import 'package:flutter/material.dart';
import 'package:shoppinglist/01_presentation/account/widgets/profile_overview.dart';
import 'package:shoppinglist/01_presentation/account/widgets/settings_account.dart';

class AccountBody extends StatelessWidget {
  const AccountBody({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        SizedBox(
          height: 20,
        ),
        ProfileOverview(),
        SettingsAccount(),
      ],
    );
  }
}
