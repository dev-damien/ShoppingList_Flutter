import 'package:shoppinglist/domain/entities/id.dart';

class ListPreview {
  final String title;
  final UniqueID imageId;

  ListPreview(
      {required this.title,
      required this.imageId}); //todo: this might become another datatype
}
