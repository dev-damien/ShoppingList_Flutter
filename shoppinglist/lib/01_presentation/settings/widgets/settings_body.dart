import 'package:flutter/material.dart';
import 'package:shoppinglist/01_presentation/settings/widgets/settings_appearence.dart';
import 'package:shoppinglist/01_presentation/settings/widgets/settings_language.dart';

class SettingsBody extends StatelessWidget {
  const SettingsBody({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        SettingsAppearence(),
        SettingsLanguage(),
      ],
    );
  }
}
