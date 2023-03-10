import 'dart:ffi';

import 'package:shoppinglist/domain/entities/id.dart';
import 'package:shoppinglist/domain/entities/item.dart';

class ListData {
  final UniqueID id;
  final String title;
  final List<UniqueID> members;
  final String imageId; //todo: this might become another datatype
  final List<Item> items;

  ListData(
      {required this.id,
      required this.title,
      required this.members,
      required this.imageId,
      required this.items});
}
