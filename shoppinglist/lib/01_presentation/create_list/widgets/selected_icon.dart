import 'package:flutter/cupertino.dart';

class SelectedIcon extends StatelessWidget {
  const SelectedIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        border: Border.fromBorderSide(
          BorderSide(color: CupertinoColors.systemGrey, width: 3),
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(5),
        ),
      ),
      child: const Icon(
        CupertinoIcons.list_bullet,
        size: 100,
      ),
    );
  }
}
