import 'package:equatable/equatable.dart';

abstract class ItemFailure with EquatableMixin {
  @override
  List<Object?> get props => [];
}

class InsufficientPermissions extends ItemFailure {}

class UnexpectedFailure extends ItemFailure {}

class UnexpectedFailureFirebase extends ItemFailure {}

class ItemDoesNotExist extends ItemFailure {}

class EmptyTitleNotAllowed extends ItemFailure {}
