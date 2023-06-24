import 'package:flutter/cupertino.dart';
import 'package:shoppinglist/01_presentation/lists_overview/widgets/lists_body.dart';

class ListsOverviewPage extends StatelessWidget {
  const ListsOverviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('Lists'),
        trailing: Icon(CupertinoIcons.add),
      ),
      child: SafeArea(
        child: ListsBody(),
      ),
    );
  }
}
