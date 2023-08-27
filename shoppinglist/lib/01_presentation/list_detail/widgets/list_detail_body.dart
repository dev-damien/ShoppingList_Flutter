import 'package:flutter/material.dart';
import 'package:shoppinglist/01_presentation/list_detail/widgets/add_item_card.dart';
import 'package:shoppinglist/01_presentation/list_detail/widgets/items_list.dart';
import 'package:shoppinglist/03_domain/entities/list.dart';

class ListDetailBody extends StatelessWidget {
  final ListData listData;

  const ListDetailBody({super.key, required this.listData});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          // ItemsList(
          //   //TODO get real items
          //   items: [],
          // ),
          //TODO only if state is AddItemsState
          AddItemCard(),
        ],
      ),
    );
  }
}
