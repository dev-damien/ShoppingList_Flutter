import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shoppinglist/domain/entities/id.dart';
import 'package:shoppinglist/domain/entities/item.dart';

class ItemModel {
  final String id;
  final String title;
  final int quantity;
  final bool isBought;
  final String addedBy;
  final String addedTime;
  final String boughtBy;
  final String boughtTime;
  final dynamic serverTimestamp;

  ItemModel(
      {required this.id,
      required this.title,
      required this.quantity,
      required this.isBought,
      required this.addedBy,
      required this.addedTime,
      required this.boughtBy,
      required this.boughtTime,
      required this.serverTimestamp});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'quantity': quantity,
      'isBought': isBought,
      'addedBy': addedBy,
      'addedTime': addedTime,
      'boughtBy': boughtBy,
      'boughtTime': boughtTime,
      'serverTimestamp': serverTimestamp,
    };
  }

  factory ItemModel.fromMap(Map<String, dynamic> map) {
    return ItemModel(
      id: "", //will be set at another point
      title: map['title'] as String,
      quantity: map['quantity'] as int,
      isBought: map['isBought'] as bool,
      addedBy: map['addedBy'] as String,
      addedTime: map['addedTime'] as String,
      boughtBy: map['boughtBy'] as String,
      boughtTime: map['boughtTime'] as String,
      serverTimestamp: map['serverTimestamp'] as dynamic,
    );
  }

  ItemModel copyWith({
    String? id,
    String? title,
    int? quantity,
    bool? isBought,
    String? addedBy,
    String? addedTime,
    String? boughtBy,
    String? boughtTime,
    dynamic serverTimestamp,
  }) {
    return ItemModel(
      id: id ?? this.id,
      title: title ?? this.title,
      quantity: quantity ?? this.quantity,
      isBought: isBought ?? this.isBought,
      addedBy: addedBy ?? this.addedBy,
      addedTime: addedTime ?? this.addedTime,
      boughtBy: boughtBy ?? this.boughtBy,
      boughtTime: boughtTime ?? this.boughtTime,
      serverTimestamp: serverTimestamp ?? this.serverTimestamp,
    );
  }

  factory ItemModel.fromFirestore(
      QueryDocumentSnapshot<Map<String, dynamic>> doc) {
    return ItemModel.fromMap(doc.data()).copyWith(id: doc.id);
  }

  Item toDomain() {
    return Item(
        addedBy: addedBy,
        addedTime: addedTime,
        boughtBy: boughtBy,
        boughtTime: boughtTime,
        id: UniqueID.fromUniqueString(id),
        isBought: isBought,
        quantity: quantity,
        title: title);
  }

  factory ItemModel.fromDomain(Item item) {
    return ItemModel(
        id: item.id.value,
        title: item.title,
        quantity: item.quantity,
        isBought: item.isBought,
        addedBy: item.addedBy,
        addedTime: item.addedTime,
        boughtBy: item.boughtBy,
        boughtTime: item.boughtTime,
        serverTimestamp: FieldValue.serverTimestamp());
  }
}
