import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:shoppinglist/02_application/items/controller/items_controller_bloc.dart';

import 'package:shoppinglist/03_domain/entities/item.dart';

class ItemCard extends StatelessWidget {
  final Item item;
  final String listId;

  const ItemCard({
    Key? key,
    required this.item,
    required this.listId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () {
        //TODO remove print and open option menu
        print("long press down on ${item.title}");
      },
      child: Slidable(
        // Specify a key if the Slidable is dismissible.
        // key: const ValueKey(0),

        // The start action pane is the one at the left or the top side.
        startActionPane: ActionPane(
          // A motion is a widget used to control how the pane animates.
          motion: const DrawerMotion(),

          // A pane can dismiss the Slidable.
          // dismissible: DismissiblePane(onDismissed: () {}),

          // All actions are defined in the children parameter.
          children: [
            // A SlidableAction can have an icon and/or a label.
            SlidableAction(
              onPressed: (context) {
                print(
                    "${item.title} -> delete by slide"); //TODO remove debug print
                final controllerBloc = context.read<ItemsControllerBloc>();
                controllerBloc
                    .add(DeleteItemEvent(listId: listId, item: item));
              },
              backgroundColor: CupertinoColors.destructiveRed,
              foregroundColor: CupertinoColors.white,
              icon: CupertinoIcons.delete,
              label: 'Delete',
            ),
            SlidableAction(
              onPressed: (context) {
                //TODO implement set bought
                print("${item.title} -> bought by slide");
              },
              backgroundColor: CupertinoColors.activeGreen,
              foregroundColor: CupertinoColors.white,
              icon: CupertinoIcons.checkmark,
              label: 'Bought',
            ),
          ],
        ),

        // The end action pane is the one at the right or the bottom side.
        endActionPane: ActionPane(
          motion: DrawerMotion(),
          children: [
            SlidableAction(
              onPressed: (context) {
                //TODO implement edit item
                print("${item.title} -> edit by slide");
              },
              backgroundColor: CupertinoColors.activeBlue,
              foregroundColor: CupertinoColors.white,
              icon: CupertinoIcons.pencil,
              label: 'Edit',
            ),
            // SlidableAction(
            //   onPressed: (context) {},
            //   backgroundColor: Color(0xFF0392CF),
            //   foregroundColor: CupertinoColors.white,
            //   icon: CupertinoIcons.memories,
            //   label: 'Save',
            // ),
          ],
        ),

        // The child of the Slidable is what the user sees when the
        // component is not dragged.
        child: CupertinoListTile(
          leading: SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: Center(
              child: Text(
                item.quantity.toString(),
                style: const TextStyle(fontSize: 22),
              ),
            ),
          ),
          title: Text(
            maxLines: 3,
            item.title,
          ),
          subtitle: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  'by ${item.addedBy}',
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Text(
                item.addedTime == null
                    ? 'unknown'
                    : DateFormat('dd.MM.yyyy HH:mm').format(
                        item.addedTime!.toDate(),
                      ),
                overflow:
                    TextOverflow.ellipsis, // Apply ellipsis for the time text
              ),
            ],
          ),
          trailing: CupertinoButton(
            child: Icon(
              CupertinoIcons.ellipsis,
            ),
            onPressed: () {
              //TODO implement show options (mark as bought, edit, delete)
              print("show options of item");
            },
          ),
        ),
      ),
    );
  }
}
