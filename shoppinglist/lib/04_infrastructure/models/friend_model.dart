import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:shoppinglist/03_domain/entities/friend.dart';
import 'package:shoppinglist/03_domain/entities/id.dart';

class FriendModel with EquatableMixin {
  final String id;
  final String nickname;
  final String imageId; //todo: this might become another datatype
  final dynamic serverTimestamp;

  FriendModel({
    required this.id,
    required this.nickname,
    required this.imageId,
    required this.serverTimestamp,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'nickname': nickname,
      'imageId': imageId,
      'serverTimestamp': serverTimestamp,
    };
  }

  factory FriendModel.fromMap(Map<String, dynamic> map) {
    return FriendModel(
      id: "", //is set later because its not part of the map
      nickname: (map['nickname'] ?? "") as String,
      imageId: (map['imageId'] ?? "no image set") as String,
      serverTimestamp: map['serverTimestamp'] as dynamic,
    );
  }

  FriendModel copyWith({
    String? id,
    String? nickname,
    String? imageId,
    dynamic serverTimestamp,
  }) {
    return FriendModel(
      id: id ?? this.id,
      nickname: nickname ?? this.nickname,
      imageId: imageId ?? this.imageId,
      serverTimestamp: serverTimestamp ?? this.serverTimestamp,
    );
  }

  factory FriendModel.fromFirestore(
      QueryDocumentSnapshot<Map<String, dynamic>> doc) {
    return FriendModel.fromMap(doc.data()).copyWith(id: doc.id);
  }

  Friend toDomain() {
    return Friend(
      id: UniqueID.fromUniqueString(id),
      nickname: nickname,
      imageId: imageId,
    );
  }

  factory FriendModel.fromDomain(Friend friend) {
    return FriendModel(
      id: friend.id.value,
      nickname: friend.nickname,
      imageId: friend.imageId,
      serverTimestamp: FieldValue.serverTimestamp(),
    );
  }

  @override
  List<Object?> get props => [
        id,
        nickname,
        imageId,
      ];
}
