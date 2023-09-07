import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoppinglist/01_presentation/create_list/widgets/added_friends_list.dart';
import 'package:shoppinglist/01_presentation/create_list/widgets/manage_members_page.dart';
import 'package:shoppinglist/01_presentation/util/icon_selection_page.dart';
import 'package:shoppinglist/02_application/lists/list_form/list_form_bloc.dart';
import 'package:shoppinglist/03_domain/entities/friend.dart';
import 'package:shoppinglist/core/failures/list_failures.dart';
import 'package:shoppinglist/core/mapper/image_mapper.dart';

class CreateListBody extends StatelessWidget {
  const CreateListBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ListFormBloc, ListFormState>(
      listener: (context, state) {},
      builder: (context, state) {
        return ListView(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  width: 50,
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 25,
                  ),
                  child: Icon(
                    ImageMapper.toIconData(state.listData.imageId),
                    size: 100,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 5,
                    right: 5,
                  ),
                  child: CupertinoButton(
                    padding: const EdgeInsets.all(0),
                    child: state.isFavorite
                        ? const Icon(
                            CupertinoIcons.star_fill,
                            size: 30,
                          )
                        : const Icon(
                            CupertinoIcons.star,
                            size: 30,
                          ),
                    onPressed: () {
                      BlocProvider.of<ListFormBloc>(context)
                          .add(ToggleIsFavoriteEvent());
                    },
                  ),
                ),
              ],
            ),
            CupertinoButton(
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(CupertinoIcons.pen),
                  Text("Change list image"),
                ],
              ),
              onPressed: () {
                _showIconSelectionDialog(context);
              },
            ),
            const Padding(
              padding: EdgeInsets.only(left: 15, right: 15),
              child: SizedBox(
                width: double.infinity,
                child: Text(
                  "Listname",
                  textAlign: TextAlign.left,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15),
              child: CupertinoTextField(
                placeholder: "Enter listname ...",
                keyboardType: TextInputType.text,
                maxLength: 20,
                onChanged: (value) {
                  // send event that title value has changed
                  BlocProvider.of<ListFormBloc>(context)
                      .add(DataChangedEvent(title: value));
                },
              ),
            ),
            Builder(builder: (context) {
              if (state.listData.title.isEmpty && state.showErrorMessages) {
                return const Padding(
                  padding: EdgeInsets.only(
                    left: 15,
                    right: 15,
                  ),
                  child: Text(
                    'Listname is required',
                    style: TextStyle(
                      color: CupertinoColors.destructiveRed,
                    ),
                  ),
                );
              }
              return const SizedBox(
                height: 20,
              );
            }),

            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15),
              child: CupertinoButton(
                onPressed: () {
                  _showManageFriendsDialog(context);
                },
                child: const Text("Add or remove users"),
              ),
            ),
            Builder(builder: (context) {
              if (state.listData.members.isEmpty) {
                return const Center(
                  child: Text(
                    "There are no other users in this list",
                  ),
                );
              } else {
                return Padding(
                  padding: const EdgeInsets.only(top: 5, left: 15, right: 15),
                  child: AddedFriendsList(),
                );
              }
            }),

            const SizedBox(
              height: 30,
            ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceAround,
            //   children: [
            //     CupertinoButton.filled(
            //       child: Text("Cancel"),
            //       onPressed: () {},
            //     ),
            //     CupertinoButton.filled(
            //       child: Text("Create"),
            //       onPressed: () {},
            //     ),
            //   ],
            // ),
          ],
        );
      },
    );
  }

  void _showIconSelectionDialog(BuildContext context) async {
    final Map<String, IconData> iconDataMap = ImageMapper.string2iconDataList
        .map((key, value) => MapEntry(key, value['default']!));
    await showCupertinoDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return IconSelectionPage(iconDataMap: iconDataMap);
      },
    ).then((value) {
      if (value != null) {
        BlocProvider.of<ListFormBloc>(context)
            .add(DataChangedEvent(imageId: value));
      }
    });
  }

  void _showManageFriendsDialog(BuildContext context) async {
    await showCupertinoDialog<List<String>>(
      context: context,
      builder: (BuildContext context) {
        return const ManageMembersPage();
      },
    );
  }
}
