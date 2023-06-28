import 'package:flutter/cupertino.dart';
import 'package:shoppinglist/01_presentation/list_detail/widgets/list_detail_body.dart';
import 'package:shoppinglist/03_domain/entities/id.dart';
import 'package:shoppinglist/03_domain/entities/item.dart';
import 'package:shoppinglist/03_domain/entities/list.dart';

class ListDetailPage extends StatelessWidget {
  UniqueID listId;
  ListData list = ListData(
    id: UniqueID.fromUniqueString("uniqueID"),
    title: "Vietnam",
    members: [],
    imageId: "imageId",
    items: List.from(
      [
        Item(
          id: UniqueID.fromUniqueString("uniqueIDItem"),
          title: "item1",
          quantity: 1,
          isBought: false,
          addedBy: "addedBy",
          addedTime: "addedTime",
          boughtBy: "boughtBy",
          boughtTime: "boughtTime",
        ),
        Item(
          id: UniqueID.fromUniqueString("uniqueIDItem"),
          title: "item2",
          quantity: 42,
          isBought: true,
          addedBy: "addedBy",
          addedTime: "addedTime",
          boughtBy: "boughtBy",
          boughtTime: "boughtTime",
        ),
        Item(
          id: UniqueID.fromUniqueString("uniqueIDItem"),
          title: "item1",
          quantity: 1,
          isBought: false,
          addedBy: "addedBy",
          addedTime: "addedTime",
          boughtBy: "boughtBy",
          boughtTime: "boughtTime",
        ),
        Item(
          id: UniqueID.fromUniqueString("uniqueIDItem"),
          title: "item1",
          quantity: 1,
          isBought: false,
          addedBy: "addedBy",
          addedTime: "addedTime",
          boughtBy: "boughtBy",
          boughtTime: "boughtTime",
        ),
        Item(
          id: UniqueID.fromUniqueString("uniqueIDItem"),
          title: "item1",
          quantity: 1,
          isBought: false,
          addedBy: "addedBy",
          addedTime: "addedTime",
          boughtBy: "boughtBy",
          boughtTime: "boughtTime",
        ),
      ],
    ),
  );

  ListDetailPage({super.key, required this.listId});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        leading: CupertinoNavigationBarBackButton(
          onPressed: () => Navigator.pop(context),
          previousPageTitle: 'Lists',
        ),
        middle: Text(listId.value),
      ),
      child: SafeArea(
        child: ListDetailBody(),
      ),
    );
  }
}
