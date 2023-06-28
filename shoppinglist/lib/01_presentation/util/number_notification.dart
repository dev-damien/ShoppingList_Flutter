import 'package:flutter/cupertino.dart';

class NumberNotification extends StatelessWidget {
  final Color backgroundColor;
  final int number;

  const NumberNotification(
      {super.key,
      this.backgroundColor = CupertinoColors.systemGrey,
      required this.number});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor, // Set the desired background color
        borderRadius:
            BorderRadius.circular(10.0), // Set the desired corner radius
      ),
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
      child: Text(
        number.toString(),
        style: const TextStyle(
          color: CupertinoColors.separator,
          fontSize: 16.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
