import 'package:flutter/material.dart';

class TabIconWithNotification extends StatelessWidget {
  final IconData iconData;
  final int notificationCount;

  const TabIconWithNotification({
    super.key,
    required this.iconData,
    required this.notificationCount,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 40,
      child: Stack(
        children: [
          Center(child: Icon(iconData)),
          if (notificationCount > 0)
            Positioned(
              top: -2,
              right: 0,
              child: Container(
                padding: EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                ),
                child: Text(
                  notificationCount.toString(),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
