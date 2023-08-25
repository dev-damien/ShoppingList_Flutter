import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoppinglist/02_application/friends/controller/friend_controller_bloc.dart';
import 'package:shoppinglist/03_domain/entities/friend.dart';
import 'package:shoppinglist/core/mapper/image_mapper.dart';
import 'package:shoppinglist/injection.dart';

class FriendCard extends StatelessWidget {
  final Friend friend;

  const FriendCard({
    Key? key,
    required this.friend,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final friendControllerBloc = sl<FriendControllerBloc>();

    return BlocProvider(
      create: (context) => friendControllerBloc,
      child: GestureDetector(
        // whole tile triggers the event, not only widgets like icon or title
        behavior: HitTestBehavior.translucent,
        onLongPress: () {
          _showFriendActionSheet(context);
        },
        child: CupertinoListTile.notched(
          leading: SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: Icon(
              ImageMapper.toIconData(friend.imageId),
              size: 30,
            ),
          ),
          title: Text(
            friend.nickname,
          ),
          subtitle: Text(
            friend.id.value,
          ),
          trailing: CupertinoButton(
            padding: EdgeInsets.zero,
            child: Icon(
              CupertinoIcons.ellipsis,
            ),
            onPressed: () {
              _showFriendActionSheet(context);
            },
          ),
        ),
      ),
    );
  }

  void _showFriendActionSheet(BuildContext context) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => CupertinoActionSheet(
        title: Text('Options for ${friend.nickname}'),
        //message: const Text('Message'),
        actions: <CupertinoActionSheetAction>[
          CupertinoActionSheetAction(
            onPressed: () {
              Navigator.pop(context);
              _showNicknameDialog(context);
            },
            child: const Text('Change nickname'),
          ),
          CupertinoActionSheetAction(
            isDestructiveAction: true,
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Remove as friend'),
          ),
        ],
      ),
    );
  }

  void _showNicknameDialog(BuildContext context) {
    String curValue = "";
    showCupertinoDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return BlocConsumer<FriendControllerBloc, FriendControllerState>(
          listener: (context, state) {
            if (state is FriendControllerSuccess) {
              Navigator.of(dialogContext).pop();
            }
          },
          builder: (context, state) {
            return CupertinoAlertDialog(
              title: state is FriendControllerInProgress
                  ? Text('Changing name ...')
                  : Text('Change Nickname'),
              content: state is FriendControllerInProgress
                  ? Center(
                      child: CupertinoActivityIndicator(),
                    )
                  : CupertinoTextField(
                      placeholder: 'New Nickname',
                      onChanged: (newNickname) {
                        curValue = newNickname;
                      },
                    ),
              actions: state is FriendControllerInProgress
                  ? <Widget>[]
                  : <Widget>[
                      CupertinoDialogAction(
                        onPressed: () {
                          Navigator.of(dialogContext).pop();
                        },
                        child: const Text('Cancel'),
                      ),
                      CupertinoDialogAction(
                        onPressed: () {
                          BlocProvider.of<FriendControllerBloc>(context).add(
                              UpdateFriendNicknameEvent(
                                  friend: friend, nickname: curValue));
                        },
                        child: const Text('Save'),
                      ),
                    ],
            );
          },
        );
      },
    );
  }
}
