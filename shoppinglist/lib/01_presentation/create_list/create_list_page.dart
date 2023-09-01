import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoppinglist/01_presentation/create_list/widgets/create_list_body.dart';
import 'package:shoppinglist/01_presentation/create_list/widgets/safe_in_progress_overlay.dart';
import 'package:shoppinglist/02_application/lists/list_form/list_form_bloc.dart';
import 'package:shoppinglist/03_domain/entities/list.dart';
import 'package:shoppinglist/injection.dart';

class CreateListPage extends StatelessWidget {
  final ListData? listData;
  final bool? isFavorite;

  const CreateListPage({
    super.key,
    required this.listData,
    required this.isFavorite,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;

    return BlocProvider(
      create: (context) => sl<ListFormBloc>()
        ..add(InitializeListEditPage(
          listData: listData,
          isFavorite: isFavorite,
        )),
      child: BlocConsumer<ListFormBloc, ListFormState>(
        listenWhen: (previous, current) =>
            previous.failureOrSuccessOption != current.failureOrSuccessOption,
        listener: (context, state) {
          state.failureOrSuccessOption.fold(
            () {},
            (eitherFailureOrSuccess) => eitherFailureOrSuccess.fold(
              (failure) {},
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
                previousPageTitle: "Lists",
              ),
              middle: state.isEditing
                  ? const Text('Edit list')
                  : const Text('Create a new List'),
              trailing: CupertinoButton(
                padding: EdgeInsets.zero,
                child: const Text("Done"),
                onPressed: () {
                  print(
                      'title=${state.listData.title}, isFav=${state.isFavorite}, imageId=${state.listData.imageId}'); //TODO remove debug print
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
      ),
    );
  }
}
