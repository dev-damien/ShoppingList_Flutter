import 'package:flutter/cupertino.dart';
import 'package:shoppinglist/01_presentation/friends/widgets/friend_requests_body.dart';

class FriendsBody extends StatelessWidget {
  const FriendsBody({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      // A list of sliver widgets.
      slivers: <Widget>[
        const CupertinoSliverNavigationBar(
          leading: Icon(CupertinoIcons.person_2),
          // This title is visible in both collapsed and expanded states.
          // When the "middle" parameter is omitted, the widget provided
          // in the "largeTitle" parameter is used instead in the collapsed state.
          largeTitle: Text('Friends'),
          trailing: Icon(CupertinoIcons.add_circled),
        ),
        // This widget fills the remaining space in the viewport.
        // Drag the scrollable area to collapse the CupertinoSliverNavigationBar.
        SliverFillRemaining(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              const Text('Drag me up', textAlign: TextAlign.center),
              CupertinoButton.filled(
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
                child: const Text('Go to Next Page'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
