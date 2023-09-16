import 'package:flutter/cupertino.dart';

class IconSelectionPage extends StatelessWidget {
  final Map<String, IconData> iconDataMap;

  const IconSelectionPage({
    super.key,
    required this.iconDataMap,
  });

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Select an Icon'),
      ),
      child: ListView.builder(
        itemCount: (iconDataMap.length / 3).ceil(),
        itemBuilder: (context, index) {
          final start = index * 3;
          final end = (index + 1) * 3;
          final currentIcons = iconDataMap.entries.toList().sublist(start, end);

          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: currentIcons.map((entry) {
              final iconTitle = entry.key;
              final iconData = entry.value;

              return CupertinoButton(
                onPressed: () {
                  // Handle icon selection here
                  print('Selected: $iconTitle');
                  Navigator.pop(
                      context, iconTitle); // Pass the selected icon back
                },
                child: Icon(
                  iconData,
                  size: 30,
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
