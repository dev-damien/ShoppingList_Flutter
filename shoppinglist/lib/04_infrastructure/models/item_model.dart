import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shoppinglist/03_domain/entities/id.dart';
import 'package:shoppinglist/03_domain/entities/item.dart';

class ItemModel {
  final String id;
  final String title;
  final int quantity;
  final String addedBy;
  final String addedTime;
  final String boughtBy;
  final String boughtTime;
  final dynamic serverTimestamp;

  ItemModel(
      {required this.id,
      required this.title,
      required this.quantity,
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
      title: (map['title'] ?? "unknown") as String,
      quantity: (map['quantity'] ?? "-1") as int,
      addedBy: (map['addedBy'] ?? "unknown") as String,
      addedTime: (map['addedTime'] ?? "unknown") as String,
      boughtBy: (map['boughtBy'] ?? "unknown") as String,
      boughtTime: (map['boughtTime'] ?? "unknown") as String,
      serverTimestamp: (map['serverTimestamp'] ?? "unknown") as dynamic,
    );
  }

  ItemModel copyWith({
    String? id,
    String? title,
    int? quantity,
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
      addedBy: addedBy ?? this.addedBy,
      addedTime: addedTime ?? this.addedTime,
      boughtBy: boughtBy ?? this.boughtBy,
      boughtTime: boughtTime ?? this.boughtTime,
      serverTimestamp: serverTimestamp ?? this.serverTimestamp,
    );
  }

  factory ItemModel.fromFirestore(DocumentSnapshot<Map<String, dynamic>> doc) {
    return ItemModel.fromMap(doc.data()!).copyWith(id: doc.id);
  }

  Item toDomain() {
    return Item(
        addedBy: addedBy,
        addedTime: addedTime,
        boughtBy: boughtBy,
        boughtTime: boughtTime,
        id: UniqueID.fromUniqueString(id),
        quantity: quantity,
        title: title);
  }

  factory ItemModel.fromDomain(Item item) {
    return ItemModel(
        id: item.id.value,
        title: item.title,
        quantity: item.quantity,
        addedBy: item.addedBy,
        addedTime: item.addedTime,
        boughtBy: item.boughtBy,
        boughtTime: item.boughtTime,
        serverTimestamp: FieldValue.serverTimestamp());
  }
}
