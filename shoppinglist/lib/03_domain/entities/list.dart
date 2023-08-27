import 'package:shoppinglist/03_domain/entities/id.dart';

class ListData {
  final UniqueID id;
  final String title;
  final List<String> members;
  final String imageId; //todo: this might become another datatype
  final List<String> admins;

  ListData({
    required this.id,
    required this.title,
    required this.members,
    required this.imageId,
    required this.admins,
  });

  factory ListData.empty() {
    return ListData(
      id: UniqueID(),
      title: "",
      members: [],
      imageId: "",
      admins: [],
    );
  }

  ListData copyWith({
    UniqueID? id,
    String? title,
    List<String>? members,
    String? imageId,
    List<String>? admins,
  }) {
    return ListData(
      id: id ?? this.id,
      title: title ?? this.title,
      members: members ?? this.members,
      imageId: imageId ?? this.imageId,
      admins: admins ?? this.admins,
    );
  }
}
