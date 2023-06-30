import 'package:equatable/equatable.dart';

abstract class FriendFailure with EquatableMixin {
  @override
  List<Object?> get props => [];
}

class InsufficientPermissions extends FriendFailure {}

class AlreadyFriends extends FriendFailure {}

class UserNotFound extends FriendFailure {}

class UnexpectedFailure extends FriendFailure {}

class UnexpectedFailureFirebase extends FriendFailure {}
