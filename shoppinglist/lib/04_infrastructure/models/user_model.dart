import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shoppinglist/03_domain/entities/id.dart';
import 'package:shoppinglist/03_domain/entities/user_data.dart';
import 'package:shoppinglist/04_infrastructure/models/list_preview_model.dart';

class UserModel {
  final String id;
  final String name;
  final String imageId; //todo: this might become another datatype
  final List<String> friendRequests;
  final List<String> friendRequestsSent;
  final dynamic serverTimestamp;

  UserModel({
    required this.id,
    required this.name,
    required this.imageId,
    required this.friendRequests,
    required this.friendRequestsSent,
    required this.serverTimestamp,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'imageId': imageId,
      'friendRequests': friendRequests,
      'friendRequestsSent': friendRequestsSent,
      'serverTimestamp': serverTimestamp,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: "",
      name: map['name'] as String,
      imageId: map['imageId'] as String,
      friendRequests:
          List<String>.from((map['friendRequests'] as List<String>)),
      friendRequestsSent:
          List<String>.from((map['friendRequestsSent'] as List<String>)),
      serverTimestamp: map['serverTimestamp'] as dynamic,
    );
  }

  UserModel copyWith({
    String? id,
    String? name,
    String? imageId,
    List<String>? friendRequests,
    List<String>? friendRequestsSent,
    List<ListPreviewModel>? listsPreview,
    dynamic serverTimestamp,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      imageId: imageId ?? this.imageId,
      friendRequests: friendRequests ?? this.friendRequests,
      friendRequestsSent: friendRequestsSent ?? this.friendRequestsSent,
      serverTimestamp: serverTimestamp ?? this.serverTimestamp,
    );
  }

  factory UserModel.fromFirestore(
      QueryDocumentSnapshot<Map<String, dynamic>> doc) {
    return UserModel.fromMap(doc.data()).copyWith(id: doc.id);
  }

  UserData toDomain() {
    return UserData(
      id: UniqueID.fromUniqueString(id),
      name: name,
      imageId: imageId,
      friendRequests: friendRequests,
      friendRequestsSent: friendRequestsSent,
    );
  }

  factory UserModel.fromDomain(UserData user) {
    return UserModel(
      id: user.id.value,
      name: user.name,
      imageId: user.imageId,
      friendRequests: user.friendRequests,
      friendRequestsSent: user.friendRequestsSent,
      serverTimestamp: FieldValue.serverTimestamp(),
    );
  }
}
