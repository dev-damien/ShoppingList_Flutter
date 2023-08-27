import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoppinglist/01_presentation/home/home_page.dart';
import 'package:shoppinglist/01_presentation/list_detail/widgets/list_detail_body.dart';
import 'package:shoppinglist/01_presentation/lists_overview/lists_overview_page.dart';
import 'package:shoppinglist/02_application/lists/observer/list_observer_bloc.dart';
import 'package:shoppinglist/03_domain/entities/id.dart';
import 'package:shoppinglist/core/failures/list_failures.dart';
import 'package:shoppinglist/injection.dart';

class ListDetailPage extends StatelessWidget {
  final UniqueID listId;

  const ListDetailPage({super.key, required this.listId});

  String mapFailureMessage(ListFailure failure) {
    switch (failure.runtimeType) {
      case InsufficientPermissions:
        return "Your permissions are insufficient.";
      case UnexpectedFailure:
        return "An unexpected error occured. Try to restart the application.";
      case UnexpectedFailureFirebase:
        return "An unexpected error occured. This should not happen.";
      case ListDoesNotExist:
        return "This list does not exist in the database.";
      default:
        return "Something went wrong";
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    final listObserverBloc = sl<ListObserverBloc>()
      ..add(ObserveListEvent(
        listId: listId.value,
      ));

    return BlocProvider(
      create: (context) => listObserverBloc,
      child: BlocConsumer<ListObserverBloc, ListObserverState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is ListObserverInitial) {
            return Container();
          }
          if (state is ListObserverLoading) {
            return const CupertinoActivityIndicator();
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
            return CupertinoPageScaffold(
              backgroundColor:
                  !isDark ? CupertinoColors.secondarySystemBackground : null,
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
                  child: Row(
                    children: [
                      CupertinoButton(
                        padding: EdgeInsets.zero,
                        child: Icon(CupertinoIcons.add),
                        onPressed: () {
                          //TODO implement add new items, switch to add items mode and add done button in right corner
                          print("switch to addItems mode");
                        },
                      ),
                      CupertinoButton(
                        padding: EdgeInsets.zero,
                        child: Icon(CupertinoIcons.ellipsis),
                        onPressed: () {
                          //TODO implement options for list (edit, leave, delete)
                          print("show options for list");
                        },
                      ),
                    ],
                  ),
                ),
              ),
              child: SafeArea(
                child: ListDetailBody(
                  listData: state.listData,
                ),
              ),
            );
          }
          return Container();
        },
      ),
    );
  }
}
