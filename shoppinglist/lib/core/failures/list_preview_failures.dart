import 'package:equatable/equatable.dart';

abstract class ListPreviewFailure with EquatableMixin {
  @override
  List<Object?> get props => [];
}

class InsufficientPermissions extends ListPreviewFailure {}

class UnexpectedFailure extends ListPreviewFailure {}

class UnexpectedFailureFirebase extends ListPreviewFailure {}
