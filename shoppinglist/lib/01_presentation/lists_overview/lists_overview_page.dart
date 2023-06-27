import 'package:flutter/cupertino.dart';
import 'package:shoppinglist/01_presentation/create_list/create_list_page.dart';
import 'package:shoppinglist/01_presentation/lists_overview/widgets/lists_body.dart';

class ListsOverviewPage extends StatelessWidget {
  const ListsOverviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: const Text('Lists'),
        trailing: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              CupertinoPageRoute<Widget>(
                builder: (BuildContext context) {
                  return const CreateListPage();
                },
              ),
            );
          }, // Call the method when the add icon is tapped
          child: const Icon(CupertinoIcons.add),
        ),
      ),
      child: const SafeArea(
        child: ListsBody(),
      ),
    );
  }
}
