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
        const SizedBox(
          height: 15,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Name: "),
            Text(userData.name),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("ID: "),
            Text(userData.id.value),
          ],
        ),
      ],
    );
  }
}
