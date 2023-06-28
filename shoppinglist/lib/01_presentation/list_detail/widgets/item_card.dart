import 'package:flutter/cupertino.dart';
import 'package:shoppinglist/03_domain/entities/item.dart';

class ItemCard extends StatelessWidget {
  final Item item;

  const ItemCard({
    Key? key,
    required this.item,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () {
        //TODO remove print and open option menu
        print("long press down on ${item.title}");
      },
      child: CupertinoListTile(
        leading: SizedBox(
          width: double.infinity,
          height: double.infinity,
          //TODO set selected icon of friend
          child: Text(item.quantity.toString()),
        ),
        title: Text(
          item.title,
        ),
        subtitle: Text("Subtitle"),
        additionalInfo: Text("additional info"),
        trailing: CupertinoButton(
          child: Icon(
            CupertinoIcons.ellipsis,
          ),
          onPressed: () {
            //TODO implement show options (mark as bought, edit, delete)
          },
        ),
      ),
    );
  }
}
