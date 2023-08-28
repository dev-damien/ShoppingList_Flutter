import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoppinglist/01_presentation/list_detail/widgets/item_card.dart';
import 'package:shoppinglist/02_application/items/observer/items_observer_bloc.dart';
import 'package:shoppinglist/core/failures/item_failures.dart';

class ItemsList extends StatefulWidget {
  final String listId;

  const ItemsList({Key? key, required this.listId}) : super(key: key);

  @override
  _ItemsListState createState() => _ItemsListState();
}

class _ItemsListState extends State<ItemsList> {
  late final ItemsObserverBloc _itemsObserverBloc;

  String mapFailureMessage(ItemFailure failure) {
    switch (failure.runtimeType) {
      case InsufficientPermissions:
        return "Your permissions are insufficient.";
      case UnexpectedFailure:
        return "An unexpected error occured. Try to restart the application.";
      case UnexpectedFailureFirebase:
        return "An unexpected error occured. This should not happen.";
      default:
        return "Something went wrong";
    }
  }

  @override
  void initState() {
    super.initState();
    _itemsObserverBloc = BlocProvider.of<ItemsObserverBloc>(context);
    _itemsObserverBloc.add(ObserveAllItemsEvent(listId: widget.listId));
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ItemsObserverBloc, ItemsObserverState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        if (state is ItemsObserverInitial) {
          return Container();
        }
        if (state is ItemsObserverLoading) {
          return const Center(
            child: CupertinoActivityIndicator(),
          );
        }
        if (state is ItemsObserverFailure) {
          return Center(
            child: Text(
              mapFailureMessage(state.itemFailure),
            ),
          );
        }
        if (state is ItemsObserverSuccess) {
          if (state.items.isEmpty) {
            return const Padding(
              padding: EdgeInsets.only(
                top: 20,
                left: 10,
                right: 10,
              ),
              child: Text(
                'This list is empty. Add an item by clicking on the \'+\' symbol in the top right corner.',
                textAlign: TextAlign.center,
              ),
            );
          }
          return CupertinoListSection(
            topMargin: 0,
            margin: const EdgeInsets.all(0),
            children: List.generate(
              state.items.length,
              (index) {
                final item = state.items[index];
                return ItemCard(
                  item: item,
                );
              },
            ),
          );
        }
        return Container();
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
