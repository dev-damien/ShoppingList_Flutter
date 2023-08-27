import 'package:shoppinglist/03_domain/entities/id.dart';

class Item {
  final UniqueID id;
  final String title;
  final int quantity;
  final String addedBy;
  final String addedTime;
  final String boughtBy;
  final String boughtTime;

  Item(
      {required this.id,
      required this.title,
      required this.quantity,
      required this.addedBy,
      required this.addedTime,
      required this.boughtBy,
      required this.boughtTime});

  factory Item.empty() {
    return Item(
        id: UniqueID(),
        title: "",
        quantity: 0,
        addedBy: "",
        addedTime: "",
        boughtBy: "",
        boughtTime: "");
  }

  Item copyWith({
    UniqueID? id,
    String? title,
    int? quantity,
    String? addedBy,
    String? addedTime,
    String? boughtBy,
    String? boughtTime,
  }) {
    return Item(
      id: id ?? this.id,
      title: title ?? this.title,
      quantity: quantity ?? this.quantity,
      addedBy: addedBy ?? this.addedBy,
      addedTime: addedTime ?? this.addedTime,
      boughtBy: boughtBy ?? this.boughtBy,
      boughtTime: boughtTime ?? this.boughtTime,
    );
  }
}
