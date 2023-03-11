import 'package:shoppinglist/domain/entities/id.dart';

class ListPreview {
  final String title;
  final UniqueID imageId;

  ListPreview(
      {required this.title,
      required this.imageId}); //todo: this might become another datatype

  factory ListPreview.empty() {
    return ListPreview(title: "", imageId: UniqueID());
  }

  ListPreview copyWith({
    String? title,
    UniqueID? imageId,
  }) {
    return ListPreview(
      title: title ?? this.title,
      imageId: imageId ?? this.imageId,
    );
  }
}
