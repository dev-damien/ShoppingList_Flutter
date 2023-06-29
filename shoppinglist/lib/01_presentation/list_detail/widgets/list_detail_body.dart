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
        left: 15,
        right: 15,
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            ItemsList(
              items: listData.items,
            ),
            SizedBox(
              height: 50,
            )
          ],
        ),
      ),
    );
  }
}
