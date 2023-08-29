import 'package:flutter/cupertino.dart';

class SafeInProgressOverlay extends StatelessWidget {
  final bool isSaving;
  const SafeInProgressOverlay({Key? key, required this.isSaving})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: !isSaving,
      child: Visibility(
        visible: isSaving,
        child: Container(
          height: double.infinity,
          width: double.infinity,
          color: CupertinoColors.inactiveGray.withOpacity(0.9),
          child: const Center(
            child: CupertinoActivityIndicator(
              radius: 30,
              color: CupertinoColors.black,
            ),
          ),
        ),
      ),
    );
  }
}
