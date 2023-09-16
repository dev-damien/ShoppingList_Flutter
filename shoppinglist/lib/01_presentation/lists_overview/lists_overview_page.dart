import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoppinglist/01_presentation/create_list/create_list_page.dart';
import 'package:shoppinglist/01_presentation/lists_overview/widgets/lists_body.dart';
import 'package:shoppinglist/02_application/friends/observer/friends_observer_bloc.dart';
import 'package:shoppinglist/02_application/lists/list_form/list_form_bloc.dart';

class ListsOverviewPage extends StatelessWidget {
  const ListsOverviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;

    return BlocConsumer<FriendsObserverBloc, FriendsObserverState>(
      listener: (context, state) {},
      builder: (context, state) {
        return CupertinoPageScaffold(
          backgroundColor:
              !isDark ? CupertinoColors.secondarySystemBackground : null,
          navigationBar: CupertinoNavigationBar(
            middle: const Text('Lists'),
            trailing: CupertinoButton(
              padding: EdgeInsets.zero,
              child: const Icon(CupertinoIcons.add, size: 30),
              onPressed: () {
                final listFormBloc = BlocProvider.of<ListFormBloc>(context);
                if (state is FriendsObserverSuccess) {
                  print('add init event'); //TODO remove debug print
                  listFormBloc.add(
                    InitializeListEditPage(
                      listData: null,
                      friends: state.friends,
                      isFavorite: null,
                    ),
                  );
                  Navigator.push(
                    context,
                    CupertinoPageRoute<Widget>(
                      builder: (BuildContext context) {
                        // create a new list -> pass nothing to widget
                        return const CreateListPage(
                          isFavorite: null,
                          listData: null,
                        );
                      },
                    ),
                  );
                }
              },
            ),
          ),
          child: const SafeArea(
            child: ListsBody(),
          ),
        );
      },
    );
  }
}
