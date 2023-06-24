// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
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
    return CupertinoListTile.notched(
      leading: const SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Icon(CupertinoIcons.list_bullet),
        //TODO set depending on selected image by user
      ),
      title: Text(
        listPreview.title,
      ),
      trailing: listPreview.isFavorite
          ? const Icon(CupertinoIcons.star)
          : const Icon(CupertinoIcons.star_fill),
    );
  }
}
