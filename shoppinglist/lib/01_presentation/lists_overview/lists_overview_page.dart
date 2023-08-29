import 'package:flutter/cupertino.dart';
import 'package:shoppinglist/01_presentation/create_list/create_list_page.dart';
import 'package:shoppinglist/01_presentation/lists_overview/widgets/lists_body.dart';

class ListsOverviewPage extends StatelessWidget {
  const ListsOverviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;

    return CupertinoPageScaffold(
      backgroundColor:
          !isDark ? CupertinoColors.secondarySystemBackground : null,
      navigationBar: CupertinoNavigationBar(
        middle: const Text('Lists'),
        trailing: CupertinoButton(
          padding: EdgeInsets.zero,
          child: Icon(CupertinoIcons.add, size: 30),
          onPressed: () {
            Navigator.push(
              context,
              CupertinoPageRoute<Widget>(
                builder: (BuildContext context) {
                  // create a new list -> pass nothing to widget
                  return CreateListPage(
                    isFavorite: null,
                    listData: null,
                  );
                },
              ),
            );
          },
        ),
      ),
      child: const SafeArea(
        child: ListsBody(),
      ),
    );
  }
}
