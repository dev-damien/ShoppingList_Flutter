import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoppinglist/01_presentation/create_list/create_list_page.dart';
import 'package:shoppinglist/01_presentation/list_detail/widgets/list_detail_body.dart';
import 'package:shoppinglist/02_application/friends/observer/friends_observer_bloc.dart';
import 'package:shoppinglist/02_application/lists/adding_mode/list_add_items_mode_bloc.dart';
import 'package:shoppinglist/02_application/lists/controller/list_controller_bloc.dart';
import 'package:shoppinglist/02_application/lists/list_form/list_form_bloc.dart';
import 'package:shoppinglist/02_application/lists/observer/list_observer_bloc.dart';
import 'package:shoppinglist/03_domain/entities/friend.dart';
import 'package:shoppinglist/03_domain/entities/id.dart';
import 'package:shoppinglist/03_domain/entities/list.dart';
import 'package:shoppinglist/injection.dart';

class ListDetailPage extends StatefulWidget {
  final UniqueID listId;

  const ListDetailPage({Key? key, required this.listId}) : super(key: key);

  @override
  _ListDetailPageState createState() => _ListDetailPageState();
}

class _ListDetailPageState extends State<ListDetailPage> {
  late final ListAddItemsModeBloc _listAddItemsModeBloc;

  @override
  void initState() {
    super.initState();
    _listAddItemsModeBloc = sl<ListAddItemsModeBloc>();
    sl<ListObserverBloc>().add(ObserveListEvent(listId: widget.listId.value));
  }

  @override
  Widget build(BuildContext context) {
    final isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;

    return MultiBlocProvider(
      providers: [
        BlocProvider.value(
          value: _listAddItemsModeBloc,
        ),
        BlocProvider(
          create: (context) => sl<ListObserverBloc>()
            ..add(
              ObserveListEvent(
                listId: widget.listId.value,
              ),
            ),
        ),
      ],
      child: BlocConsumer<ListObserverBloc, ListObserverState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is ListObserverInitial) {
            return Container();
          }
          if (state is ListObserverLoading) {
            return const Center(
              child: CupertinoActivityIndicator(),
            );
          }
          if (state is ListObserverFailure) {
            return CupertinoPageScaffold(
              backgroundColor: CupertinoColors.systemGroupedBackground,
              navigationBar: CupertinoNavigationBar(
                leading: CupertinoNavigationBarBackButton(
                  onPressed: () => Navigator.pop(context),
                  previousPageTitle: 'Lists',
                  color: CupertinoColors.activeBlue,
                ),
                middle: const Text('Error',
                    style: TextStyle(color: CupertinoColors.label)),
                backgroundColor: CupertinoColors.systemBackground,
              ),
              child: SafeArea(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.error_outline,
                        color: CupertinoColors.destructiveRed,
                        size: 64,
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'Oops! The list does not exist.',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: CupertinoColors.label,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'It seems like there is some problem with the datasource.',
                        style: TextStyle(
                          fontSize: 18,
                          color: CupertinoColors.secondaryLabel,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 32),
                      CupertinoButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        color: CupertinoColors.activeBlue,
                        child: const Text(
                          'Go Back',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: CupertinoColors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
          if (state is ListObserverSuccess) {
            return BlocConsumer<ListAddItemsModeBloc, ListAddItemsModeState>(
              listener: (context, mode) {},
              builder: (context, mode) {
                return BlocConsumer<FriendsObserverBloc, FriendsObserverState>(
                  listener: (context, friendsState) {
                    // TODO: implement listener
                  },
                  builder: (context, friendsState) {
                    return CupertinoPageScaffold(
                      backgroundColor: !isDark
                          ? CupertinoColors.secondarySystemBackground
                          : null,
                      navigationBar: CupertinoNavigationBar(
                        leading: CupertinoNavigationBarBackButton(
                          onPressed: () => Navigator.pop(context),
                          previousPageTitle: 'Lists',
                        ),
                        middle: Text(
                          state.listData.title,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                        trailing: FittedBox(
                          child: mode is ListAddItemsModeDeactivated
                              ? Row(
                                  children: [
                                    CupertinoButton(
                                      padding: EdgeInsets.zero,
                                      child: const Icon(CupertinoIcons.add),
                                      onPressed: () {
                                        _listAddItemsModeBloc
                                            .add(ActivateAddItemsModeEvent());
                                      },
                                    ),
                                    CupertinoButton(
                                      padding: EdgeInsets.zero,
                                      child:
                                          const Icon(CupertinoIcons.ellipsis),
                                      onPressed: () {
                                        _showListActionSheet(
                                            context,
                                            state.listData,
                                            friendsState
                                                    is FriendsObserverSuccess
                                                ? friendsState.friends
                                                : []);
                                      },
                                    ),
                                  ],
                                )
                              : CupertinoButton(
                                  padding: EdgeInsets.zero,
                                  child: const Text('Done'),
                                  onPressed: () {
                                    _listAddItemsModeBloc
                                        .add(DeactivateAddItemsModeEvent());
                                  },
                                ),
                        ),
                      ),
                      child: SafeArea(
                        child: ListDetailBody(
                          isAddingMode: mode is ListAddItemsModeActivated,
                          listData: state.listData,
                        ),
                      ),
                    );
                  },
                );
              },
            );
          }
          return Container();
        },
      ),
    );
  }

  @override
  void dispose() {
    _listAddItemsModeBloc.close();
    super.dispose();
  }

  void _showListActionSheet(
    BuildContext context,
    ListData listData,
    List<Friend> friends,
  ) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => CupertinoActionSheet(
        title: Text('Options for ${listData.title}'),
        actions: <CupertinoActionSheetAction>[
          CupertinoActionSheetAction(
            onPressed: () {
              Navigator.pop(context);

              final listFormBloc = BlocProvider.of<ListFormBloc>(context);
              print('add init event for edit'); //TODO remove debug print
              listFormBloc.add(
                InitializeListEditPage(
                  listData: listData,
                  friends: friends,
                  isFavorite: null,
                ),
              );
              Navigator.push(
                context,
                CupertinoPageRoute<Widget>(
                  builder: (BuildContext context) {
                    // edit an existing list -> pass current data to widget
                    return CreateListPage(
                      isFavorite: null,
                      listData: listData,
                    );
                  },
                ),
              );
            },
            child: const Text('Edit list'),
          ),
          CupertinoActionSheetAction(
            onPressed: () {
              Navigator.pop(context);
              //TODO leave list
            },
            child: const Text('Leave list'),
          ),
          CupertinoActionSheetAction(
            isDestructiveAction: true,
            onPressed: () {
              Navigator.pop(context);
              _showDeleteListDialog(context, listData);
            },
            child: const Text('Delete List'),
          ),
        ],
      ),
    );
  }

  //TODO delete list
  void _showDeleteListDialog(BuildContext context, ListData listData) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) =>
          BlocConsumer<ListControllerBloc, ListControllerState>(
        listener: (context, state) {
          if (state is ListControllerSuccess) {
            Navigator.of(context).pop();
          }
        },
        builder: (context, state) {
          final isLoading = state is ListControllerInProgress;
          return CupertinoAlertDialog(
            title: isLoading
                ? Text('Deleting list ${listData.title}')
                : Text('Do you want to delete the list ${listData.title}'),
            content: isLoading
                ? const Center(
                    child: CupertinoActivityIndicator(),
                  )
                : const Text(
                    'This action will delete all items in this list for all members.'),
            actions: isLoading
                ? []
                : <CupertinoDialogAction>[
                    CupertinoDialogAction(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('Cancel'),
                    ),
                    CupertinoDialogAction(
                      onPressed: () {
                        BlocProvider.of<ListControllerBloc>(context)
                            .add(DeleteListEvent(listId: listData.id.value));
                      },
                      isDestructiveAction: true,
                      child: const Text('Delete'),
                    ),
                  ],
          );
        },
      ),
    );
  }
}
