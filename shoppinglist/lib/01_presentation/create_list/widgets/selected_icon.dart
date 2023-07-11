import 'package:flutter/cupertino.dart';

class SelectedIcon extends StatelessWidget {
  const SelectedIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return const Icon(
      CupertinoIcons.list_bullet,
      size: 100,
    );
  }
}
