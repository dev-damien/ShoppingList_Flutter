import 'dart:ffi';

import 'package:shoppinglist/domain/entities/id.dart';
import 'package:shoppinglist/domain/entities/item.dart';

class ListData {
  final UniqueID id;
  final String title;
  final List<UniqueID> members;
  final UniqueID imageId; //todo: this might become another datatype
  final List<Item> items;

  ListData(
      {required this.id,
      required this.title,
      required this.members,
      required this.imageId,
      required this.items});

  factory ListData.empty() {
    return ListData(
        id: UniqueID(),
        title: "",
        members: List.empty(),
        imageId: UniqueID(),
        items: List.empty());
  }

  ListData copyWith({
    UniqueID? id,
    String? title,
    List<UniqueID>? members,
    UniqueID? imageId,
    List<Item>? items,
  }) {
    return ListData(
      id: id ?? this.id,
      title: title ?? this.title,
      members: members ?? this.members,
      imageId: imageId ?? this.imageId,
      items: items ?? this.items,
    );
  }
}
