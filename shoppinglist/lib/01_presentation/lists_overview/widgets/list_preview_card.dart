// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shoppinglist/03_domain/entities/list_preview.dart';

class ListPreviewCard extends StatelessWidget {
  final ListPreview listPreview;

  const ListPreviewCard({
    Key? key,
    required this.listPreview,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return Card(
      elevation: 16,
      color: themeData.colorScheme.onPrimary, //TODO change color
      margin: const EdgeInsets.only(top: 3, left: 2, right: 2),
      child: CupertinoListTile(
        backgroundColor: themeData.colorScheme.onBackground,
        leading: const Icon(
          CupertinoIcons.square_list,
          size: 40,
        ), //TODO set depending on selected image by user
        title: Text(
          listPreview.title,
          style: themeData.textTheme.headlineLarge!.copyWith(
              fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        trailing: listPreview.isFavorite
            ? const Icon(CupertinoIcons.star)
            : const Icon(CupertinoIcons.star_fill),
      ),
    );
  }
}
