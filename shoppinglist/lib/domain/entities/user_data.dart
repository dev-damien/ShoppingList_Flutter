import 'package:shoppinglist/domain/entities/id.dart';
import 'package:shoppinglist/domain/entities/list_preview.dart';

class UserData {
  final UniqueID id;
  final String name;
  final String imageId; //todo: this might become another datatype
  final List<String> favourites;
  final List<String> friendRequests;
  final List<String> friendRequestsSent;
  final List<String> friends;
  final List<ListPreview> listsPreview;

  UserData(
      {required this.listsPreview,
      required this.id,
      required this.name,
      required this.imageId,
      required this.favourites,
      required this.friendRequests,
      required this.friendRequestsSent,
      required this.friends});

  factory UserData.empty() {
    return UserData(
        listsPreview: List.empty(),
        id: UniqueID(),
        name: "",
        imageId: "",
        favourites: List<String>.empty(),
        friendRequests: List<String>.empty(),
        friendRequestsSent: List<String>.empty(),
        friends: List<String>.empty());
  }

  UserData copyWith({
    UniqueID? id,
    String? name,
    String? imageId,
    List<String>? favourites,
    List<String>? friendRequests,
    List<String>? friendRequestsSent,
    List<String>? friends,
    List<ListPreview>? listsPreview,
  }) {
    return UserData(
      id: id ?? this.id,
      name: name ?? this.name,
      imageId: imageId ?? this.imageId,
      favourites: favourites ?? this.favourites,
      friendRequests: friendRequests ?? this.friendRequests,
      friendRequestsSent: friendRequestsSent ?? this.friendRequestsSent,
      friends: friends ?? this.friends,
      listsPreview: listsPreview ?? this.listsPreview,
    );
  }
}
