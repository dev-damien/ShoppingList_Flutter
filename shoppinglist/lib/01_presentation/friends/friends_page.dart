import 'package:flutter/cupertino.dart';
import 'friend_requests_page.dart';

class FriendsBody extends StatelessWidget {
  const FriendsBody({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text("Friends"),
        trailing: Icon(CupertinoIcons.person_add),
      ),
      child: SafeArea(
        //todo UI finetuning: maybe use .filled for normal button. depends on final design decisions
        child: CupertinoButton(
          onPressed: () {
            Navigator.push(
              context,
              CupertinoPageRoute<Widget>(
                builder: (BuildContext context) {
                  return const FriendRequestsPage();
                },
              ),
            );
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Friend Requests'),
              const SizedBox(
                width: 10,
              ),
              Container(
                decoration: BoxDecoration(
                  color: CupertinoColors
                      .lightBackgroundGray, // Set the desired background color
                  borderRadius: BorderRadius.circular(
                      10.0), // Set the desired corner radius
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                child: const Text(
                  '3', //todo set the real amount of requests
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
