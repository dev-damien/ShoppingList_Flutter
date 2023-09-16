import 'package:flutter/cupertino.dart';
import 'package:shoppinglist/03_domain/entities/user_data.dart';
import 'package:shoppinglist/core/mapper/image_mapper.dart';

class ProfileOverview extends StatelessWidget {
  final UserData userData;

  const ProfileOverview({required this.userData, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          ImageMapper.toIconData(userData.imageId),
          size: 80,
        ),
        Row(
          children: [
            Text("Name: "),
            Text(userData.name),
          ],
          mainAxisAlignment: MainAxisAlignment.center,
        ),
        Row(
          children: [
            Text("ID: "),
            Text(userData.id.value),
          ],
          mainAxisAlignment: MainAxisAlignment.center,
        ),
      ],
    );
  }
}
