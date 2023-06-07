import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:shoppinglist/core/failures/list_preview_failures.dart';
import 'package:shoppinglist/03_domain/entities/list_preview.dart';
import 'package:shoppinglist/03_domain/repositories/list_preview_repository.dart';

part 'observer_event.dart';
part 'observer_state.dart';

class ObserverBloc extends Bloc<ObserverEvent, ObserverState> {
  final ListPreviewRepository listPreviewRepository;

  StreamSubscription<Either<ListPreviewFailure, List<ListPreview>>>?
      _listPreviewStreamSub;

  ObserverBloc({required this.listPreviewRepository})
      : super(ObserverInitial()) {
    on<ObserveAllEvent>((event, emit) async {
      emit(ObserverLoading());
      await _listPreviewStreamSub?.cancel();
      _listPreviewStreamSub = listPreviewRepository.watchAll().listen(
          (failureOrListPreviews) => add(ListPreviewsUpdatedEvent(
              failureOrListPreviews: failureOrListPreviews)));
    });
    on<ListPreviewsUpdatedEvent>((event, emit) {
      event.failureOrListPreviews.fold(
          (failures) => emit(ObserverFailure(listPreviewFailure: failures)),
          (listPreviews) => emit(ObserverSuccess(listPreviews: listPreviews)));
    });
  }

  @override
  Future<void> close() async {
    await _listPreviewStreamSub?.cancel();
    return super.close();
  }
}
