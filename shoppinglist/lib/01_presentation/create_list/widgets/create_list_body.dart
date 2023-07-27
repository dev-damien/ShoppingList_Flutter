import 'package:flutter/cupertino.dart';
import 'package:shoppinglist/01_presentation/create_list/widgets/added_friends_list.dart';
import 'package:shoppinglist/01_presentation/create_list/widgets/selected_icon.dart';

class CreateListBody extends StatelessWidget {
  const CreateListBody({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 35,
            ),
            Padding(
              padding: EdgeInsets.only(
                top: 25,
              ),
              child: SelectedIcon(),
            ),
            Padding(
              padding: EdgeInsets.only(
                top: 5,
                right: 5,
              ),
              child: Icon(
                CupertinoIcons.star,
                size: 30,
              ),
            ),
          ],
        ),
        CupertinoButton(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(CupertinoIcons.pen),
              Text("Change list image"),
            ],
          ),
          onPressed: () {},
        ),
        Padding(
          padding: EdgeInsets.only(left: 15, right: 15),
          child: Container(
            width: double.infinity,
            child: Text(
              "Listname",
              textAlign: TextAlign.left,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 15, right: 15),
          child: CupertinoTextField(
            placeholder: "Enter listname ...",
            keyboardType: TextInputType.text,
            maxLength: 20,
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Padding(
          padding: EdgeInsets.only(left: 15, right: 15),
          child: CupertinoButton(
            onPressed: () {},
            child: Text("Add friends to your list"),
          ),
        ),
        //todo if no frinds in group
        Center(
          child: Text(
            "There are currently no friends added",
          ),
        ),
        //TODO if friends added, display here in scrollable list
        Padding(
          padding: const EdgeInsets.only(top: 5, left: 15, right: 15),
          child: AddedFriendsList(),
        ),
        SizedBox(
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
  }
}
