import 'package:flutter/cupertino.dart';

class IconSelectionPage extends StatelessWidget {
  final Map<String, IconData> iconDataMap;

  final int iconsPerRow = 4;

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
        itemCount: (iconDataMap.length / iconsPerRow).ceil(),
        itemBuilder: (context, index) {
          final start = index * iconsPerRow;
          int end = ((index + 1) * iconsPerRow);
          // end is max the last element of the map
          end = end > iconDataMap.length ? iconDataMap.length : end;
          final currentIcons = iconDataMap.entries.toList().sublist(start, end);

          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: currentIcons.map((entry) {
              final iconTitle = entry.key;
              final iconData = entry.value;

              return CupertinoButton(
                onPressed: () {
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
