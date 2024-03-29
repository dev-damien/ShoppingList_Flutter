import 'package:flutter/material.dart';
import 'package:shoppinglist/01_presentation/list_detail/widgets/add_item_card.dart';
import 'package:shoppinglist/01_presentation/list_detail/widgets/items_list.dart';
import 'package:shoppinglist/03_domain/entities/list.dart';

class ListDetailBody extends StatelessWidget {
  final ListData listData;
  final bool isAddingMode;

  const ListDetailBody({
    super.key,
    required this.listData,
    required this.isAddingMode,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          isAddingMode
              ? AddItemCard(
                  listId: listData.id.value,
                  item: null,
                )
              : const SizedBox(
                  height: 0,
                ),
          ItemsList(
            listId: listData.id.value,
          ),
        ],
      ),
    );
  }
}
