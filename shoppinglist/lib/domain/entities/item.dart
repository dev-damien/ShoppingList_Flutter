import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shoppinglist/domain/entities/id.dart';

class Item {
  final UniqueID id;
  final String title;
  final int quantity;
  final bool isBought;
  final UniqueID addedBy;
  final Timestamp addedTime;
  final UniqueID? boughtBy;
  final Timestamp? boughtTime;

  Item(
      {required this.id,
      required this.title,
      required this.quantity,
      required this.isBought,
      required this.addedBy,
      required this.addedTime,
      this.boughtBy,
      this.boughtTime});
}
