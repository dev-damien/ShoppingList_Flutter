import 'package:shoppinglist/domain/entities/id.dart';

class ListPreview {
  final UniqueID id;
  final String title;
  final String imageId;

  ListPreview(
      {required this.id,
      required this.title,
      required this.imageId}); //todo: this might become another datatype

  factory ListPreview.empty() {
    return ListPreview(id: UniqueID(), title: "", imageId: "");
  }

  ListPreview copyWith({
    UniqueID? id,
    String? title,
    String? imageId,
  }) {
    return ListPreview(
      id: id ?? this.id,
      title: title ?? this.title,
      imageId: imageId ?? this.imageId,
    );
  }
}
