import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shoppinglist/domain/entities/id.dart';
import 'package:shoppinglist/domain/entities/list_preview.dart';
import 'package:shoppinglist/domain/entities/user_data.dart';
import 'package:shoppinglist/infrastructure/models/list_preview_model.dart';

class UserModel {
  final String id;
  final String name;
  final String imageId; //todo: this might become another datatype
  final List<String> favourites;
  final List<String> friendRequests;
  final List<String> friendRequestsSent;
  final List<String> friends;
  final List<ListPreviewModel> listsPreview;
  final dynamic serverTimestamp;

  UserModel(
      {required this.listsPreview,
      required this.id,
      required this.name,
      required this.imageId,
      required this.favourites,
      required this.friendRequests,
      required this.friendRequestsSent,
      required this.friends,
      required this.serverTimestamp});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'imageId': imageId,
      'favourites': favourites,
      'friendRequests': friendRequests,
      'friendRequestsSent': friendRequestsSent,
      'friends': friends,
      'listsPreview': listsPreview,
      'serverTimestamp': serverTimestamp,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: "",
      name: map['name'] as String,
      imageId: map['imageId'] as String,
      favourites: List<String>.from((map['favourites'] as List<String>)),
      friendRequests:
          List<String>.from((map['friendRequests'] as List<String>)),
      friendRequestsSent:
          List<String>.from((map['friendRequestsSent'] as List<String>)),
      friends: List<String>.from((map['friends'] as List<String>)),
      listsPreview: List<ListPreviewModel>.from(
          (map['listsPreview'] as List<ListPreviewModel>)),
      serverTimestamp: map['serverTimestamp'] as dynamic,
    );
  }

  UserModel copyWith({
    String? id,
    String? name,
    String? imageId,
    List<String>? favourites,
    List<String>? friendRequests,
    List<String>? friendRequestsSent,
    List<String>? friends,
    List<ListPreviewModel>? listsPreview,
    dynamic serverTimestamp,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      imageId: imageId ?? this.imageId,
      favourites: favourites ?? this.favourites,
      friendRequests: friendRequests ?? this.friendRequests,
      friendRequestsSent: friendRequestsSent ?? this.friendRequestsSent,
      friends: friends ?? this.friends,
      listsPreview: listsPreview ?? this.listsPreview,
      serverTimestamp: serverTimestamp ?? this.serverTimestamp,
    );
  }

  factory UserModel.fromFirestore(
      QueryDocumentSnapshot<Map<String, dynamic>> doc) {
    return UserModel.fromMap(doc.data()).copyWith(id: doc.id);
  }

  UserData toDomain() {
    List<ListPreview> listsPreviewDomain = List<ListPreview>.empty();
    for (ListPreviewModel listPreview in listsPreview) {
      listsPreviewDomain.add(listPreview.toDomain());
    }
    List<ListPreview> listsPreviewDomain2 =
        (listsPreview.map<ListPreview>((e) => e.toDomain())).toList();
    print(listsPreviewDomain);
    print("--------------------------------------");
    print(listsPreviewDomain2);
    return UserData(
        listsPreview: listsPreviewDomain,
        id: UniqueID.fromUniqueString(id),
        name: name,
        imageId: imageId,
        favourites: favourites,
        friendRequests: friendRequests,
        friendRequestsSent: friendRequestsSent,
        friends: friends);
  }

  factory UserModel.fromDomain(UserData user) {
    List<ListPreviewModel> listsPreviewModel = (user.listsPreview
        .map<ListPreviewModel>((e) => ListPreviewModel.fromDomain(e))).toList();

    return UserModel(
        listsPreview: listsPreviewModel,
        id: user.id.value,
        name: user.name,
        imageId: user.imageId,
        favourites: user.favourites,
        friendRequests: user.friendRequests,
        friendRequestsSent: user.friendRequestsSent,
        friends: user.friends,
        serverTimestamp: FieldValue.serverTimestamp());
  }
}
