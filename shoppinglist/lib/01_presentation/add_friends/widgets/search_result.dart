import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoppinglist/02_application/friend_requests/controller/friend_request_controller_bloc.dart';
import 'package:shoppinglist/02_application/friends/observer/friends_observer_bloc.dart';
import 'package:shoppinglist/02_application/user/observer/user_observer_bloc.dart';
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
      child: BlocConsumer<UserObserverBloc, UserObserverState>(
        listener: (context, userState) {
          // TODO: implement listener
        },
        builder: (context, userState) {
          return BlocConsumer<FriendsObserverBloc, FriendsObserverState>(
            listener: (context, friendsState) {},
            builder: (context, friendsState) {
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
                      builder: (context, requestState) {
                        if (userState is UserObserverSuccess &&
                            friendsState is FriendsObserverSuccess) {
                          print(
                              '${user.name}: user and friends loaded'); //TODO remove debug print
                          // friends and requests are loaded
                          if (requestState is FriendRequestControllerInitial ||
                              requestState is FriendRequestControllerSuccess) {
                            print(
                                '${user.name}: initial or success'); //TODO remove debug print
                            if (userState.userData.friendRequests
                                .contains(user.id.value)) {
                              print(
                                  '${user.name}: target requested user'); //TODO remove debug print
                              // show button to accept request
                              return CupertinoButton(
                                child: Icon(
                                  CupertinoIcons.check_mark_circled_solid,
                                  size: 30,
                                  color: CupertinoColors.activeOrange,
                                ),
                                onPressed: () {
                                  _showAlertDialogTargetRequestedUser(context);
                                },
                                padding: EdgeInsets.only(right: 0),
                              );
                            } else if (userState.userData.friendRequestsSent
                                .contains(user.id.value)) {
                              print(
                                  '${user.name}: already requested'); //TODO remove debug print
                              // target user has already been requested
                              return CupertinoButton(
                                child: Icon(
                                  CupertinoIcons
                                      .person_crop_circle_badge_exclam,
                                  size: 30,
                                  color: CupertinoColors.systemGrey,
                                ),
                                onPressed: () {
                                  _showAlertDialogAlreadyRequested(context);
                                },
                                padding: EdgeInsets.only(right: 0),
                              );
                            } else if (friendsState.friends
                                .map((friend) => friend.id.value)
                                .toList()
                                .contains(user.id.value)) {
                              print(
                                  '${user.name}: already friends'); //TODO remove debug print
                              // target user is already friend of user
                              return CupertinoButton(
                                child: Icon(
                                  CupertinoIcons.person_2_fill,
                                  size: 30,
                                  color: CupertinoColors.activeGreen,
                                ),
                                onPressed: () {
                                  _showAlertDialogAlreadyFriends(context);
                                },
                                padding: EdgeInsets.only(right: 0),
                              );
                            }
                            print(friendsState.friends
                                .map((friend) => friend.id.value)
                                .toList()); //TODO remove debug print
                            print(
                                '${user.name}: no requests in any way'); //TODO remove debug print
                            return CupertinoButton(
                              child: Icon(
                                CupertinoIcons.add_circled_solid,
                                size: 30,
                              ),
                              onPressed: () {
                                friendRequestControllerBloc.add(
                                  RequestFriendEvent(
                                      targetUserId: user.id.value),
                                );
                              },
                              padding: EdgeInsets.only(right: 0),
                            );
                          }
                          if (requestState is FriendRequestControllerLoading) {
                            return const Center(
                              child: CupertinoActivityIndicator(),
                            );
                          }
                          if (requestState is FriendRequestControllerFailure) {
                            //todo show error popup
                          }
                        }
                        // friends or requests not loaded
                        return Container();
                      },
                    ),
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }

  void _showAlertDialogAlreadyRequested(BuildContext context) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: Text('You have already sent a request to ${user.name}'),
        content: const Text(
            'Wait for the other person to accept or decline your request. You could go for a cup of tea while waiting ...'),
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
        title: Text('You are already friends with ${user.name}'),
        content: const Text(
            'Maybe you are VERY close friends, but there are other ways to show this :)'),
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

  void _showAlertDialogTargetRequestedUser(BuildContext context) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: Text('The user ${user.name} requested to be friends with you'),
        content: const Text('Do you want to be friends with this user?'),
        actions: <CupertinoDialogAction>[
          CupertinoDialogAction(
            isDestructiveAction: true,
            onPressed: () {
              //TODO decline request
              print('decline request'); //TODO remove debug print
              Navigator.pop(context);
            },
            child: const Text('Decline'),
          ),
          CupertinoDialogAction(
            onPressed: () {
              //TODO accept user as friend
              print('accept request'); //TODO remove debug print
              Navigator.pop(context);
            },
            child: const Text('Accept'),
          ),
        ],
      ),
    );
  }
}
