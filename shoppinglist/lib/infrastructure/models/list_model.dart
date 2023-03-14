import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shoppinglist/domain/entities/id.dart';
import 'package:shoppinglist/domain/entities/item.dart';
import 'package:shoppinglist/domain/entities/list.dart';
import 'package:shoppinglist/infrastructure/models/item_model.dart';

class ListModel {
  final String id;
  final String title;
  final List<String> members;
  final String imageId; //todo: this might become another datatype
  final List<ItemModel> items;
  final dynamic serverTimestamp;

  ListModel(
      {required this.id,
      required this.title,
      required this.members,
      required this.imageId,
      required this.items,
      required this.serverTimestamp});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'members': members,
      'imageId': imageId,
      'items': items.map((x) => x.toMap()).toList(),
      'serverTimestamp': serverTimestamp,
    };
  }

  factory ListModel.fromMap(Map<String, dynamic> map) {
    return ListModel(
      id: "", //is set later because its not part of the map
      title: map['title'] as String,
      members: List<String>.from((map['members'] as List<String>)),
      imageId: map['imageId'] as String,
      items: List<ItemModel>.from(
        (map['items'] as List<int>).map<ItemModel>(
          (x) => ItemModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
      serverTimestamp: map['serverTimestamp'] as dynamic,
    );
  }

  ListModel copyWith({
    String? id,
    String? title,
    List<String>? members,
    String? imageId,
    List<ItemModel>? items,
    dynamic serverTimestamp,
  }) {
    return ListModel(
      id: id ?? this.id,
      title: title ?? this.title,
      members: members ?? this.members,
      imageId: imageId ?? this.imageId,
      items: items ?? this.items,
      serverTimestamp: serverTimestamp ?? this.serverTimestamp,
    );
  }

  factory ListModel.fromFirestore(
      QueryDocumentSnapshot<Map<String, dynamic>> doc) {
    return ListModel.fromMap(doc.data()).copyWith(id: doc.id);
  }

  ListData toDomain() {
    List<Item> itemsDomain = List<Item>.empty();
    for (ItemModel item in items) {
      itemsDomain.add(item.toDomain());
    }

    return ListData(
      id: UniqueID.fromUniqueString(id),
      title: title,
      members: members,
      imageId: imageId,
      items: itemsDomain,
    );
  }

  factory ListModel.fromDomain(ListData list) {
    List<ItemModel> itemModels = List<ItemModel>.empty();
    for (Item item in list.items) {
      itemModels.add(ItemModel.fromDomain(item));
    }
    return ListModel(
        id: list.id.value,
        title: list.title,
        members: list.members,
        imageId: list.imageId,
        items: itemModels,
        serverTimestamp: FieldValue.serverTimestamp());
  }
}
