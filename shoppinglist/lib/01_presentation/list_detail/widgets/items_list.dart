import 'package:flutter/cupertino.dart';
import 'package:shoppinglist/01_presentation/list_detail/widgets/item_card.dart';
import 'package:shoppinglist/03_domain/entities/item.dart';

class ItemsList extends StatelessWidget {
  List<Item> items;

  ItemsList({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return CupertinoListSection(
      topMargin: 0,
      margin: EdgeInsets.all(0),
      children: List.generate(
        items.length,
        (index) {
          final item = items[index];
          return ItemCard(
            item: item,
          );
        },
      ),
    );
  }
}
