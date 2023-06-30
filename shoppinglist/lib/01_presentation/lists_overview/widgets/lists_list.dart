import 'package:flutter/cupertino.dart';
import 'package:shoppinglist/03_domain/entities/list_preview.dart';

import 'list_preview_card.dart';

class ListsList extends StatelessWidget {
  final List<ListPreview> listPreviews;

  const ListsList({
    Key? key,
    required this.listPreviews,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context)
          .size
          .height, // Constrain the height to fit within the available space
      child: CustomScrollView(
        slivers: [
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final listPreview = listPreviews[index];
                return ListPreviewCard(
                  listPreview: listPreview,
                );
              },
              childCount: listPreviews.length,
            ),
          ),
        ],
      ),
    );
  }
}
