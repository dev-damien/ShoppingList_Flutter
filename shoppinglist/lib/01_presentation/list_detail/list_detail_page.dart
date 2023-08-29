import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoppinglist/01_presentation/list_detail/widgets/list_detail_body.dart';
import 'package:shoppinglist/02_application/lists/adding_mode/list_add_items_mode_bloc.dart';
import 'package:shoppinglist/02_application/lists/observer/list_observer_bloc.dart';
import 'package:shoppinglist/03_domain/entities/id.dart';
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
                                  child: Icon(CupertinoIcons.add),
                                  onPressed: () {
                                    _listAddItemsModeBloc
                                        .add(ActivateAddItemsModeEvent());
                                  },
                                ),
                                CupertinoButton(
                                  padding: EdgeInsets.zero,
                                  child: Icon(CupertinoIcons.ellipsis),
                                  onPressed: () {
                                    // TODO open settings menu for list
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
}
