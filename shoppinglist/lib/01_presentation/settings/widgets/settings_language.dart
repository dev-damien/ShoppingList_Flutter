import 'package:flutter/cupertino.dart';

class SettingsLanguage extends StatelessWidget {
  const SettingsLanguage({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoListSection.insetGrouped(
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
    );
  }
}
