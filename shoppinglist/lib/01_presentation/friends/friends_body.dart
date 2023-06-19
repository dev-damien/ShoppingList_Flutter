import 'package:flutter/material.dart';

class FriendsBody extends StatelessWidget {
  const FriendsBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 200,
      decoration: BoxDecoration(
        color: Colors.blue,
        border: Border.all(
          color: Colors.red,
          width: 2,
        ),
      ),
    );
  }
}
