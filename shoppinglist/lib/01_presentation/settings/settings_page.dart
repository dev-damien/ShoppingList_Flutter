import 'package:flutter/cupertino.dart';
import 'package:shoppinglist/01_presentation/settings/widgets/settings_account.dart';
import 'package:shoppinglist/01_presentation/settings/widgets/settings_appearence.dart';
import 'package:shoppinglist/01_presentation/settings/widgets/settings_language.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const CupertinoPageScaffold(
      child: Column(
        children: [
          SettingsAppearence(),
          SettingsLanguage(),
          Expanded(child: SettingsAccount()),
        ],
      ),
    );
  }
}
