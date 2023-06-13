import 'package:shoppinglist/03_domain/entities/id.dart';
import 'package:shoppinglist/03_domain/entities/item.dart';

class ListData {
  final UniqueID id;
  final String title;
  final List<String> members;
  final String imageId; //todo: this might become another datatype
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
        imageId: "",
        items: List.empty());
  }

  ListData copyWith({
    UniqueID? id,
    String? title,
    List<String>? members,
    String? imageId,
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
