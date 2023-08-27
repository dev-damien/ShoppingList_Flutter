import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shoppinglist/03_domain/entities/id.dart';
import 'package:shoppinglist/03_domain/entities/list.dart';
import 'package:shoppinglist/core/failures/list_failures.dart';

class ListModel {
  final String id;
  final String title;
  final List<String> members;
  final String imageId; //todo: this might become another datatype
  final List<String> admins;
  final dynamic serverTimestamp;

  ListModel({
    required this.id,
    required this.title,
    required this.members,
    required this.imageId,
    required this.serverTimestamp,
    required this.admins,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'members': members,
      'imageId': imageId,
      'serverTimestamp': serverTimestamp,
      'admins': admins,
    };
  }

  factory ListModel.fromMap(Map<String, dynamic> map) {
    return ListModel(
      id: "", //is set later because its not part of the map
      title: (map['title'] ?? 'unknown') as String,
      members: List<String>.from((map['members'] ?? [])),
      imageId: (map['imageId'] ?? 'unknown') as String,
      serverTimestamp: (map['serverTimestamp'] ?? 'unknown') as dynamic,
      admins: List<String>.from((map['admins'] ?? [])),
    );
  }

  ListModel copyWith({
    String? id,
    String? title,
    List<String>? members,
    String? imageId,
    dynamic serverTimestamp,
    List<String>? admins,
  }) {
    return ListModel(
      id: id ?? this.id,
      title: title ?? this.title,
      members: members ?? this.members,
      imageId: imageId ?? this.imageId,
      serverTimestamp: serverTimestamp ?? this.serverTimestamp,
      admins: admins ?? this.admins,
    );
  }

  factory ListModel.fromFirestore(DocumentSnapshot<Map<String, dynamic>> doc) {
    if (doc.data() == null) throw ListDoesNotExist();
    return ListModel.fromMap(doc.data()!).copyWith(id: doc.id);
  }

  ListData toDomain() {
    return ListData(
      id: UniqueID.fromUniqueString(id),
      title: title,
      members: members,
      imageId: imageId,
      admins: admins,
    );
  }

  factory ListModel.fromDomain(ListData list) {
    return ListModel(
      id: list.id.value,
      title: list.title,
      members: list.members,
      imageId: list.imageId,
      serverTimestamp: FieldValue.serverTimestamp(),
      admins: list.admins,
    );
  }
}
