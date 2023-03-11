import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

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
      required this.boughtBy,
      required this.boughtTime});

  factory Item.empty() {
    return Item(
        id: UniqueID(),
        title: "",
        quantity: 0,
        isBought: false,
        addedBy: UniqueID(),
        addedTime: Timestamp(0, 0),
        boughtBy: null,
        boughtTime: null);
  }

  Item copyWith({
    UniqueID? id,
    String? title,
    int? quantity,
    bool? isBought,
    UniqueID? addedBy,
    Timestamp? addedTime,
    UniqueID? boughtBy,
    Timestamp? boughtTime,
  }) {
    return Item(
      id: id ?? this.id,
      title: title ?? this.title,
      quantity: quantity ?? this.quantity,
      isBought: isBought ?? this.isBought,
      addedBy: addedBy ?? this.addedBy,
      addedTime: addedTime ?? this.addedTime,
      boughtBy: boughtBy ?? this.boughtBy,
      boughtTime: boughtTime ?? this.boughtTime,
    );
  }
}
