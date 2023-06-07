part of 'observer_bloc.dart';

@immutable
abstract class ObserverEvent {}

class ObserveAllEvent extends ObserverEvent {}

class ListPreviewsUpdatedEvent extends ObserverEvent {
  final Either<ListPreviewFailure, List<ListPreview>> failureOrListPreviews;

  ListPreviewsUpdatedEvent({required this.failureOrListPreviews});
}
