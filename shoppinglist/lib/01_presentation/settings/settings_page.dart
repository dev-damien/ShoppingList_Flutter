import 'package:flutter/cupertino.dart';
import 'package:shoppinglist/01_presentation/settings/widgets/settings_body.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('Settings'),
      ),
      child: Container(
        height: double.infinity,
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: SafeArea(
            child: SettingsBody(),
          ),
        ),
      ),
    );
  }
}
