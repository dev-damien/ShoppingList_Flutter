import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoppinglist/01_presentation/create_list/widgets/create_list_body.dart';
import 'package:shoppinglist/01_presentation/create_list/widgets/safe_in_progress_overlay.dart';
import 'package:shoppinglist/02_application/friends/observer/friends_observer_bloc.dart';
import 'package:shoppinglist/02_application/lists/list_form/list_form_bloc.dart';
import 'package:shoppinglist/03_domain/entities/list.dart';

class CreateListPage extends StatefulWidget {
  final ListData? listData;
  final bool? isFavorite;

  const CreateListPage({
    super.key,
    required this.listData,
    required this.isFavorite,
  });

  @override
  _CreateListPageState createState() => _CreateListPageState(
        listData: listData,
        isFavorite: isFavorite,
      );
}

class _CreateListPageState extends State<CreateListPage> {
  final ListData? listData;
  final bool? isFavorite;

  _CreateListPageState({
    this.listData,
    this.isFavorite,
  });

  @override
  void initState() {
    super.initState();
    // final listFormBloc = BlocProvider.of<ListFormBloc>(context);
    // final friendsObserverBloc = BlocProvider.of<FriendsObserverBloc>(context);
    // // Now you can listen to the observerBloc's state in initState
    // friendsObserverBloc.stream.listen((state) {
    //   if (state is FriendsObserverSuccess) {
    //     listFormBloc.add(
    //       InitializeListEditPage(
    //         listData: listData,
    //         friends: state.friends,
    //         isFavorite: isFavorite,
    //       ),
    //     );
    //   }
    // });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;

    return BlocConsumer<FriendsObserverBloc, FriendsObserverState>(
      listener: (context, friendsState) {},
      builder: (context, state) {
        return BlocConsumer<ListFormBloc, ListFormState>(
          listenWhen: (previous, current) =>
              previous.failureOrSuccessOption != current.failureOrSuccessOption,
          listener: (context, state) {
            state.failureOrSuccessOption.fold(
              () {},
              (eitherFailureOrSuccess) => eitherFailureOrSuccess.fold(
                (failure) {
                  _showTitleRequiredDialog(context);
                },
                (success) {
                  Navigator.of(context).pop();
                },
              ),
            );
          },
          builder: (context, state) {
            return CupertinoPageScaffold(
              backgroundColor:
                  !isDark ? CupertinoColors.secondarySystemBackground : null,
              navigationBar: CupertinoNavigationBar(
                leading: CupertinoNavigationBarBackButton(
                  onPressed: () => Navigator.pop(context),
                  previousPageTitle: state.isEditing ? 'Cancel' : "Lists",
                ),
                middle: state.isEditing
                    ? const Text('Edit list')
                    : const Text('Create a new List'),
                trailing: CupertinoButton(
                  padding: EdgeInsets.zero,
                  child: const Text("Done"),
                  onPressed: () {
                    print(
                        'title=${state.listData.title}, isFav=${state.isFavorite}, imageId=${state.listData.imageId}, members=${state.listData.members.join(', ')}');
                    BlocProvider.of<ListFormBloc>(context).add(SafePressedEvent(
                      title: state.listData.title,
                      isFavorite: state.isFavorite,
                      imageId: state.listData.imageId,
                      members: state.members,
                    ));
                  },
                ),
              ),
              child: SafeArea(
                child: Stack(
                  children: [
                    CreateListBody(),
                    SafeInProgressOverlay(isSaving: state.isSaving),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  void _showTitleRequiredDialog(BuildContext context) {
    showCupertinoDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: const Text("Listname is required"),
          content: const Text("You must enter a name for the list."),
          actions: <Widget>[
            CupertinoDialogAction(
              child: const Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
