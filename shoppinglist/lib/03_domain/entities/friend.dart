import 'package:shoppinglist/03_domain/entities/id.dart';

class Friend {
  final UniqueID id;
  final String nickname;
  final String imageId;

  Friend({
    required this.id,
    required this.nickname,
    required this.imageId,
  });

  factory Friend.empty() {
    return Friend(
      id: UniqueID(),
      nickname: "",
      imageId: '',
    );
  }

  Friend copyWith({
    UniqueID? id,
    String? nickname,
    String? imageId,
  }) {
    return Friend(
      id: id ?? this.id,
      nickname: nickname ?? this.nickname,
      imageId: imageId ?? this.imageId,
    );
  }
}
