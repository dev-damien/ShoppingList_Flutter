import 'package:shoppinglist/domain/entities/id.dart';
import 'package:shoppinglist/domain/entities/list_preview.dart';

class UserData {
  final UniqueID id;
  final String name;
  final UniqueID imageId; //todo: this might become another datatype
  final List<UniqueID> favourites;
  final List<UniqueID> friendRequests;
  final List<UniqueID> friendRequestsSent;
  final List<UniqueID> friends;
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
        imageId: UniqueID(),
        favourites: List.empty(),
        friendRequests: List.empty(),
        friendRequestsSent: List.empty(),
        friends: List.empty());
  }

  UserData copyWith({
    UniqueID? id,
    String? name,
    UniqueID? imageId,
    List<UniqueID>? favourites,
    List<UniqueID>? friendRequests,
    List<UniqueID>? friendRequestsSent,
    List<UniqueID>? friends,
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
