import 'package:equatable/equatable.dart';

abstract class ListFailure with EquatableMixin {
  @override
  List<Object?> get props => [];
}

class InsufficientPermissions extends ListFailure {}

class UnexpectedFailure extends ListFailure {}

class UnexpectedFailureFirebase extends ListFailure {}

class ListDoesNotExist extends ListFailure {}
