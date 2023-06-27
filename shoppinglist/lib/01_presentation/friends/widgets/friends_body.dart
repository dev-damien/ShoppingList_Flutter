import 'package:flutter/cupertino.dart';
import 'package:shoppinglist/01_presentation/friends/widgets/friends_list.dart';
import 'package:shoppinglist/01_presentation/friends/widgets/friends_requests_button.dart.dart';

class FriendsBody extends StatelessWidget {
  const FriendsBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FriendsRequestsButton(),
        Padding(
          padding: const EdgeInsets.only(
            left: 15,
            right: 15,
          ),
          child: FriendsList(),
        ),
      ],
    );
  }
}
