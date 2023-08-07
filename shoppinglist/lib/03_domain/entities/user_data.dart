import 'package:shoppinglist/03_domain/entities/id.dart';

class UserData {
  final UniqueID id;
  final String name;
  final String imageId; //todo: this might become another datatype
  final List<String> friendRequests;
  final List<String> friendRequestsSent;

  UserData({
    required this.id,
    required this.name,
    required this.imageId,
    required this.friendRequests,
    required this.friendRequestsSent,
  });

  factory UserData.empty() {
    return UserData(
      id: UniqueID(),
      name: "",
      imageId: "",
      friendRequests: List<String>.empty(),
      friendRequestsSent: List<String>.empty(),
    );
  }

  UserData copyWith({
    UniqueID? id,
    String? name,
    String? imageId,
    List<String>? friendRequests,
    List<String>? friendRequestsSent,
    List<String>? friends,
  }) {
    return UserData(
      id: id ?? this.id,
      name: name ?? this.name,
      imageId: imageId ?? this.imageId,
      friendRequests: friendRequests ?? this.friendRequests,
      friendRequestsSent: friendRequestsSent ?? this.friendRequestsSent,
    );
  }
}
