import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shoppinglist/domain/entities/id.dart';
import 'package:shoppinglist/domain/entities/list_preview.dart';

class ListPreviewModel {
  final String id;
  final String title;
  final String imageId; //todo: this might become another datatype
  final dynamic serverTimestamp;

  ListPreviewModel(
      {required this.id,
      required this.title,
      required this.imageId,
      required this.serverTimestamp});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'imageId': imageId,
      'serverTimestamp': serverTimestamp,
    };
  }

  factory ListPreviewModel.fromMap(Map<String, dynamic> map) {
    return ListPreviewModel(
      id: "", //is set later because its not part of the map
      title: map['title'] as String,
      imageId: map['image_id'] as String,
      serverTimestamp: map['serverTimestamp'] as dynamic,
    );
  }

  ListPreviewModel copyWith({
    String? id,
    String? title,
    String? imageId,
    dynamic serverTimestamp,
  }) {
    return ListPreviewModel(
      id: id ?? this.id,
      title: title ?? this.title,
      imageId: imageId ?? this.imageId,
      serverTimestamp: serverTimestamp ?? this.serverTimestamp,
    );
  }

  factory ListPreviewModel.fromFirestore(
      QueryDocumentSnapshot<Map<String, dynamic>> doc) {
    return ListPreviewModel.fromMap(doc.data()).copyWith(id: doc.id);
  }

  ListPreview toDomain() {
    return ListPreview(
      id: UniqueID.fromUniqueString(id),
      title: title,
      imageId: imageId,
    );
  }

  factory ListPreviewModel.fromDomain(ListPreview listPreview) {
    return ListPreviewModel(
        id: listPreview.id.value,
        title: listPreview.title,
        imageId: listPreview.imageId,
        serverTimestamp: FieldValue.serverTimestamp());
  }
}
