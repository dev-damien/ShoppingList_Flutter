import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:shoppinglist/03_domain/entities/id.dart';
import 'package:shoppinglist/03_domain/entities/list_preview.dart';

class ListPreviewModel with EquatableMixin {
  final String id;
  final String title;
  final String imageId; //todo: this might become another datatype
  final bool isFavorite;
  final dynamic serverTimestamp;

  ListPreviewModel(
      {required this.id,
      required this.title,
      required this.imageId,
      required this.isFavorite,
      required this.serverTimestamp});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'imageId': imageId,
      'isFavorite': isFavorite,
      'serverTimestamp': serverTimestamp,
    };
  }

  factory ListPreviewModel.fromMap(Map<String, dynamic> map) {
    return ListPreviewModel(
      id: "", //is set later because its not part of the map
      title: (map['title'] ?? "new list") as String,
      imageId: (map['imageId'] ?? "no image") as String,
      isFavorite: (map['isFavorite'] ?? false) as bool,
      serverTimestamp: map['serverTimestamp'] as dynamic,
    );
  }

  ListPreviewModel copyWith({
    String? id,
    String? title,
    String? imageId,
    bool? isFavorite,
    dynamic serverTimestamp,
  }) {
    return ListPreviewModel(
      id: id ?? this.id,
      title: title ?? this.title,
      imageId: imageId ?? this.imageId,
      isFavorite: isFavorite ?? this.isFavorite,
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
        isFavorite: isFavorite);
  }

  factory ListPreviewModel.fromDomain(ListPreview listPreview) {
    return ListPreviewModel(
        id: listPreview.id.value,
        title: listPreview.title,
        imageId: listPreview.imageId,
        isFavorite: listPreview.isFavorite,
        serverTimestamp: FieldValue.serverTimestamp());
  }

  @override
  List<Object?> get props => [id, title, imageId, isFavorite];
}
