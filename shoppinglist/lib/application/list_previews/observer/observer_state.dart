part of 'observer_bloc.dart';

@immutable
abstract class ObserverState {}

class ObserverInitial extends ObserverState {}

class ObserverLoading extends ObserverState {}

class ObserverFailure extends ObserverState {
  final ListPreviewFailure listPreviewFailure;
  ObserverFailure({required this.listPreviewFailure});
}

class ObserverSuccess extends ObserverState {
  final List<ListPreview> listPreviews;
  ObserverSuccess({required this.listPreviews});
}
