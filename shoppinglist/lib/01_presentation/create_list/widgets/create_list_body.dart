import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoppinglist/01_presentation/create_list/widgets/added_friends_list.dart';
import 'package:shoppinglist/01_presentation/create_list/widgets/selected_icon.dart';
import 'package:shoppinglist/02_application/lists/list_form/list_form_bloc.dart';

class CreateListBody extends StatelessWidget {
  const CreateListBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ListFormBloc, ListFormState>(
      listener: (context, state) {
      },
      builder: (context, state) {
        return ListView(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  width: 35,
                ),
                const Padding(
                  padding: EdgeInsets.only(
                    top: 25,
                  ),
                  child: SelectedIcon(),
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
              onPressed: () {},
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
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15),
              child: CupertinoButton(
                onPressed: () {},
                child: Text("Add friends to your list"),
              ),
            ),
            //todo if no frinds in group
            const Center(
              child: Text(
                "There are currently no friends added",
              ),
            ),
            //TODO if friends added, display here in scrollable list
            Padding(
              padding: const EdgeInsets.only(top: 5, left: 15, right: 15),
              child: AddedFriendsList(),
            ),
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
}
