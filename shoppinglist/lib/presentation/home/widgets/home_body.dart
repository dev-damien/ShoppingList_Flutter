import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoppinglist/application/list_previews/observer/observer_bloc.dart';
import 'package:shoppinglist/presentation/home/widgets/list_preview_card.dart';

class HomeBody extends StatelessWidget {
  const HomeBody({super.key});

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return BlocBuilder<ObserverBloc, ObserverState>(
      builder: (context, state) {
        if (state is ObserverInitial) {
          return Container();
        }
        if (state is ObserverLoading) {
          return Center(
            child: CircularProgressIndicator(
              color: themeData.colorScheme.secondary,
            ),
          );
        }
        if (state is ObserverFailure) {
          return const Center(child: Text("Failure"));
        }
        if (state is ObserverSuccess) {
          return ListView.builder(
              itemCount: state.listPreviews.length,
              itemBuilder: (context, index) {
                final listPreview = state.listPreviews[index];
                return ListPreviewCard(
                  listPreview: listPreview,
                );
              });
        }
        return Container();
      },
    );
  }
}
