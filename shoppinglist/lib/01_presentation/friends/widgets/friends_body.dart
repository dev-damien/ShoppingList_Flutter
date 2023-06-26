import 'package:flutter/cupertino.dart';
import 'package:shoppinglist/01_presentation/friends/widgets/friends_requests_button.dart.dart';

class FriendsBody extends StatelessWidget {
  const FriendsBody({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        FriendsRequestsButton(),
      ],
    );
  }
}
