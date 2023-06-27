import 'package:flutter/cupertino.dart';
import 'package:shoppinglist/01_presentation/create_list/widgets/create_list_body.dart';

class CreateListPage extends StatelessWidget {
  const CreateListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: CupertinoColors.secondarySystemBackground,
      navigationBar: CupertinoNavigationBar(
        leading: CupertinoNavigationBarBackButton(
          onPressed: () => Navigator.pop(context),
          previousPageTitle: "Lists",
        ),
        middle: const Text('Create a new List'),
        trailing: CupertinoButton(
          padding: EdgeInsets.zero,
          child: Text("Done"),
          onPressed: () {},
        ),
      ),
      child: const SafeArea(
        child: CreateListBody(),
      ),
    );
  }
}
