import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoppinglist/02_application/friend_requests/controller_respond/friend_request_respond_bloc.dart';
import 'package:shoppinglist/03_domain/entities/user_data.dart';
import 'package:shoppinglist/core/enums/friend_request_responses.dart';
import 'package:shoppinglist/core/failures/friend_failures.dart';
import 'package:shoppinglist/core/mapper/image_mapper.dart';
import 'package:shoppinglist/injection.dart';

class FriendRequestCard extends StatelessWidget {
  final UserData userData;

  const FriendRequestCard({
    Key? key,
    required this.userData,
  }) : super(key: key);

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
    final friendRequestRespondBloc = sl<FriendRequestRespondBloc>();

    return BlocProvider(
      create: (context) => friendRequestRespondBloc,
      child: CupertinoListTile.notched(
        leading: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Icon(
            ImageMapper.toIconData(userData.imageId),
            size: 30,
          ),
        ),
        title: Text(
          userData.name,
        ),
        subtitle: Text(
          userData.id.value,
          overflow: TextOverflow.ellipsis,
        ),
        trailing:
            BlocConsumer<FriendRequestRespondBloc, FriendRequestRespondState>(
          listener: (context, state) {
            // TODO: implement listener
          },
          builder: (context, state) {
            if (state is FriendRequestRespondLoading) {
              return const Center(
                child: CupertinoActivityIndicator(),
              );
            }
            if (state is FriendRequestRespondFailure) {
              _showAlertDialogRespondError(
                context,
                state.type,
                state.failure,
              );
              return Center(
                child: CupertinoButton(
                  onPressed: () {
                    _showAlertDialogRespondError(
                      context,
                      state.type,
                      state.failure,
                    );
                  },
                  child: Text('Error'),
                ),
              );
            }
            if (state is FriendRequestRespondSuccess) {
              final type = state.type;
              String typeText;

              if (type == FriendRequestResponse.accept) {
                typeText = "accepting";
              } else if (type == FriendRequestResponse.decline) {
                typeText = "declining";
              } else if (type == FriendRequestResponse.block) {
                typeText = "blocking";
              } else {
                typeText = "unknown"; // Handle any other cases
              }

              _showAlertDialogRespondSuccess(
                context,
                type,
              );

              return Center(
                child: Text(typeText),
              );
            }
            // state is initial, show accept/decline option
            return Row(
              children: [
                CupertinoButton(
                  child: const Column(
                    children: [
                      Icon(
                        CupertinoIcons.clear_circled_solid,
                        color: CupertinoColors.destructiveRed,
                        size: 25,
                      ),
                      Text(
                        'Decline',
                        style: TextStyle(
                          fontSize: 14,
                          color: CupertinoColors.destructiveRed,
                        ),
                      ),
                    ],
                  ),
                  onPressed: () {
                    friendRequestRespondBloc.add(
                      DeclineFriendRequestEvent(
                          targetUserId: userData.id.value),
                    );
                  },
                ),
                CupertinoButton(
                  child: const Column(
                    children: [
                      Icon(
                        CupertinoIcons.check_mark_circled_solid,
                        color: CupertinoColors.activeGreen,
                        size: 25,
                      ),
                      Text(
                        'Accept',
                        style: TextStyle(
                          fontSize: 14,
                          color: CupertinoColors.activeGreen,
                        ),
                      )
                    ],
                  ),
                  onPressed: () {
                    friendRequestRespondBloc.add(
                      AcceptFriendRequestEvent(targetUserId: userData.id.value),
                    );
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  void _showAlertDialogRespondError(
    BuildContext context,
    FriendRequestResponse type,
    FriendFailure failure,
  ) {
    final typeText = type == FriendRequestResponse.accept
        ? "accepting"
        : type == FriendRequestResponse.decline
            ? "declining"
            : type == FriendRequestResponse.block
                ? "blocking"
                : "with";

    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext parentContext) => CupertinoAlertDialog(
        title: const Text('Ups. An Error occured.'),
        content: Text(
            'It seems like something went wrong $typeText ${userData.name}. Restarting the app might fix this problem.\n (Error: ${failure.runtimeType})'),
        actions: <CupertinoDialogAction>[
          CupertinoDialogAction(
            onPressed: () {
              Navigator.pop(parentContext);
            },
            child: const Text('Ok'),
          ),
        ],
      ),
    );
  }

  void _showAlertDialogRespondSuccess(
    BuildContext parentContext,
    FriendRequestResponse type,
  ) {
    print('success dialog?'); //TODO remove debug print
    String title;
    String description;
    if (type == FriendRequestResponse.accept) {
      title = "accepted";
      description =
          "Now, you can create lists together with ${userData.name} or add him/her to existing ones.";
      _showAlertDialogRespondSuccess(parentContext, type);
    } else if (type == FriendRequestResponse.decline) {
      title = "declined";
      description =
          "If you are sure you dont know ${userData.name}, consider blocking him/her.";
    } else if (type == FriendRequestResponse.block) {
      title = "blocked";
      description =
          "The user ${userData.name} is no longer be able to request you.";
    } else {
      title = "unknown"; // Handle any other cases
      description = "If you read this text, I'm stupid :(";
    }

    showCupertinoModalPopup<void>(
      context: parentContext,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: Text('Successfully $title ${userData.name}'),
        content: Text(description),
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
