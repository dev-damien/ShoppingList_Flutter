// GroupMembersBloc
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoppinglist/02_application/friends/observer/friends_observer_bloc.dart';
import 'package:shoppinglist/02_application/lists/list_form/list_form_bloc.dart';
import 'package:shoppinglist/03_domain/entities/friend.dart';
import 'package:shoppinglist/core/mapper/image_mapper.dart';

class ManageMembersPage extends StatelessWidget {
  const ManageMembersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Edit list members'),
      ),
      child: SafeArea(
        child: BlocBuilder<FriendsObserverBloc, FriendsObserverState>(
          builder: (context, friendsState) {
            return BlocBuilder<ListFormBloc, ListFormState>(
              builder: (context, formState) {
                if (friendsState is FriendsObserverFailure) {
                  return const Center(
                    child: Text('Cound not load friends'),
                  );
                }
                if (friendsState is FriendsObserverSuccess) {
                  final currentMembers = formState.members;
                  List<Friend> suggestedFriends =
                      List.from(friendsState.friends);
                  suggestedFriends = suggestedFriends
                    ..removeWhere((friend) => currentMembers
                        .map((member) => member.id.value)
                        .contains(friend.id.value));
                  return CupertinoListSection(
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      const Text('Current Members:'),
                      Builder(builder: (context) {
                        if (formState.members.isEmpty) {
                          return const Padding(
                            padding: EdgeInsets.only(
                              top: 10,
                              bottom: 10,
                            ),
                            child: Center(
                              child: Text('No users are in this list'),
                            ),
                          );
                        } else {
                          return const SizedBox();
                        }
                      }),
                      for (final member in currentMembers)
                        CupertinoListTile(
                          leading: Icon(ImageMapper.toIconData(member.imageId)),
                          title: Text(member.nickname),
                          trailing: CupertinoButton(
                            child: const Text('Remove'),
                            onPressed: () {
                              BlocProvider.of<ListFormBloc>(context)
                                  .add(RemoveMemberEvent(user: member));
                            },
                          ),
                        ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text('Suggested Friends:'),
                      Builder(builder: (context) {
                        if (friendsState.friends.isEmpty) {
                          return const Padding(
                            padding: EdgeInsets.only(
                              top: 10,
                              bottom: 10,
                            ),
                            child: Center(
                              child: Text('You have no friends to add'),
                            ),
                          );
                        } else {
                          return const SizedBox();
                        }
                      }),
                      for (final friend in suggestedFriends)
                        CupertinoListTile(
                          leading: Icon(ImageMapper.toIconData(friend.imageId)),
                          title: Text(friend.nickname),
                          trailing: CupertinoButton(
                            child: const Text('Add'),
                            onPressed: () {
                              print(
                                  'onpress triggered to add user'); //TODO remove debug print
                              BlocProvider.of<ListFormBloc>(context)
                                  .add(AddMemberEvent(user: friend));
                            },
                          ),
                        ),
                    ],
                  );
                }
                return const Center(
                  child: CupertinoActivityIndicator(),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
