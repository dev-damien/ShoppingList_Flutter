import 'package:flutter/cupertino.dart';
import 'package:shoppinglist/01_presentation/list_detail/list_detail_page.dart';
import 'package:shoppinglist/03_domain/entities/list_preview.dart';

class ListPreviewCard extends StatelessWidget {
  final ListPreview listPreview;

  const ListPreviewCard({
    Key? key,
    required this.listPreview,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoListTile.notched(
      leading: const SizedBox(
        width: double.infinity,
        height: double.infinity,
        //TODO set depending on selected image by user
        child: Padding(
          padding: EdgeInsets.zero,
          child: Icon(
            CupertinoIcons.square_list_fill,
            size: 35,
          ),
        ),
      ),
      title: Text(
        listPreview.title,
      ),
      trailing: listPreview.isFavorite
          ? const Icon(CupertinoIcons.star)
          : const Icon(CupertinoIcons.star_fill),
      onTap: () {
        Navigator.push(
          context,
          CupertinoPageRoute<Widget>(
            builder: (BuildContext context) {
              return ListDetailPage(
                listId: listPreview.id,
              );
            },
          ),
        );
      },
    );
  }
}
