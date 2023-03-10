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
}
