import 'package:flutter/material.dart';
import 'package:shoppinglist/01_presentation/list_detail/widgets/add_item_card.dart';
import 'package:shoppinglist/01_presentation/list_detail/widgets/items_list.dart';
import 'package:shoppinglist/03_domain/entities/list.dart';

class ListDetailBody extends StatelessWidget {
  ListData listData;

  ListDetailBody({super.key, required this.listData});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          ItemsList(
            items: listData.items,
          ),
          //TODO only if state is AddItemsState
          AddItemCard(),
        ],
      ),
    );
  }
}
