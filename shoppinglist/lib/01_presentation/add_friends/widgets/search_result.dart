import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoppinglist/02_application/friend_requests/controller/friend_request_controller_bloc.dart';
import 'package:shoppinglist/02_application/friends/observer/friends_observer_bloc.dart';
import 'package:shoppinglist/03_domain/entities/user_data.dart';
import 'package:shoppinglist/core/failures/friend_failures.dart';
import 'package:shoppinglist/core/mapper/image_mapper.dart';
import 'package:shoppinglist/injection.dart';

class SearchResult extends StatelessWidget {
  final UserData user;
  const SearchResult({
    required this.user,
    super.key,
  });

  String mapFailureMessage(FriendFailure failure) {
    switch (failure.runtimeType) {
      case InsufficientPermissions:
        return "Your permissions are insufficient.";
      case UnexpectedFailure:
        return "An unexpected error occured. Try to restart the application.";
      case UnexpectedFailureFirebase:
        return "An unexpected error occured. This should not happen.";
      case AlreadyFriends:
        return "You are already friends with this user";
      case AlreadyRequested:
        return "User has already been requested";
      default:
        return "Something went wrong";
    }
  }

  @override
  Widget build(BuildContext context) {
    final friendRequestControllerBloc = sl<FriendRequestControllerBloc>();

    return BlocProvider(
      create: (context) => friendRequestControllerBloc,
      child: BlocConsumer<FriendsObserverBloc, FriendsObserverState>(
        listener: (context, state) {},
        builder: (context, state) {
          return CupertinoListSection.insetGrouped(
            margin: EdgeInsets.all(10),
            topMargin: 0,
            children: [
              CupertinoListTile.notched(
                leadingSize: double.parse('42.0'),
                leading: Icon(
                  ImageMapper.toIconData(user.imageId),
                  size: 40,
                ),
                title: Text(user.name),
                subtitle: Text(user.id.value),
                trailing: BlocConsumer<FriendRequestControllerBloc,
                    FriendRequestControllerState>(
                  listener: (context, state) {
                    if (state is FriendRequestControllerFailure) {
                      if (state.friendFailure is AlreadyRequested) {
                        _showAlertDialogAlreadyRequested(context);
                      } else if (state.friendFailure is AlreadyFriends) {
                        _showAlertDialogAlreadyFriends(context);
                      }
                    }
                  },
                  builder: (context, state) {
                    if (state is FriendRequestControllerInitial) {
                      return CupertinoButton(
                        child: Icon(
                          CupertinoIcons.add_circled_solid,
                          size: 30,
                        ),
                        onPressed: () {
                          friendRequestControllerBloc.add(
                            RequestFriendEvent(targetUserId: user.id.value),
                          );
                        },
                        padding: EdgeInsets.only(right: 0),
                      );
                    }
                    if (state is FriendRequestControllerLoading) {
                      return const Center(
                        child: CupertinoActivityIndicator(),
                      );
                    }
                    if (state is FriendRequestControllerFailure) {
                      //todo show error popup
                    }
                    if (state is FriendRequestControllerSuccess) {
                      return Icon(
                          CupertinoIcons.person_crop_circle_badge_exclam);
                    }
                    return Container();
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  void _showAlertDialogAlreadyRequested(BuildContext context) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: const Text('Alert'),
        content: const Text('Proceed with destructive action?'),
        actions: <CupertinoDialogAction>[
          CupertinoDialogAction(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Ok'),
          ),
        ],
      ),
    );
  }

  void _showAlertDialogAlreadyFriends(BuildContext context) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: const Text('Alert'),
        content: const Text('Proceed with destructive action?'),
        actions: <CupertinoDialogAction>[
          CupertinoDialogAction(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Ok'),
          ),
        ],
      ),
    );
  }
}
