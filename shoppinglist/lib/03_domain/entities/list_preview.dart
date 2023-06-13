import 'package:shoppinglist/03_domain/entities/id.dart';

class ListPreview {
  final UniqueID id;
  final String title;
  final String imageId;
  final bool isFavorite;

  //todo: imageId might become another datatype
  ListPreview(
      {required this.id,
      required this.title,
      required this.imageId,
      required this.isFavorite});

  factory ListPreview.empty() {
    return ListPreview(
        id: UniqueID(), title: "", imageId: "", isFavorite: false);
  }

  ListPreview copyWith({
    UniqueID? id,
    String? title,
    String? imageId,
    bool? isFavorite,
  }) {
    return ListPreview(
      id: id ?? this.id,
      title: title ?? this.title,
      imageId: imageId ?? this.imageId,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
}
