import 'package:flutter/material.dart';
import 'package:shoppinglist/01_presentation/list_detail/widgets/items_list.dart';
import 'package:shoppinglist/03_domain/entities/list.dart';

class ListDetailBody extends StatelessWidget {
  ListData listData;

  ListDetailBody({super.key, required this.listData});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: 20,
        left: 15,
        right: 15,
      ),
      child: ItemsList(items: listData.items,),
    );
  }
}
