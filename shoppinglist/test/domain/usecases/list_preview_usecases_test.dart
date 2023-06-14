import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:shoppinglist/03_domain/entities/id.dart';
import 'package:shoppinglist/03_domain/entities/list_preview.dart';
import 'package:shoppinglist/03_domain/repositories/list_preview_repository.dart';
import 'package:shoppinglist/03_domain/usecases/list_preview_usecases.dart';
import 'package:shoppinglist/core/failures/list_preview_failures.dart';

import 'list_preview_usecases_test.mocks.dart';

@GenerateMocks([ListPreviewRepository])
void main() {
  late ListPreviewUsecases listPreviewUsecases;
  late MockListPreviewRepository mockListPreviewRepository;

  setUp(() {
    mockListPreviewRepository = MockListPreviewRepository();
    listPreviewUsecases =
        ListPreviewUsecases(listPreviewRepository: mockListPreviewRepository);
  });

  group("list-preview-usecase: watchAll", () {
    final ListPreview listPreview = ListPreview(
        id: UniqueID.fromUniqueString("c0ffeebabe"),
        title: "TestGroup1",
        imageId: "ghijk",
        isFavorite: true);

    final Stream<Either<ListPreviewFailure, List<ListPreview>>>
        listPreviewStream =
        Stream<Either<ListPreviewFailure, List<ListPreview>>>.fromIterable([
      Right([listPreview])
    ]);

    test("should return the same listPreview as repo", () {
      //* arrange
      when(mockListPreviewRepository.watchAll())
          .thenAnswer((_) => listPreviewStream);

      //* act
      final result = listPreviewUsecases.watchAll();

      //* assert
      result.listen((element) {
        expect(element.isRight(), true);

        List<ListPreview> value = element.getOrElse(() => []);
        expect(value, List.of([listPreview]));

        // verify that method is called
        verify(mockListPreviewRepository.watchAll());
        // verify that class is called only used once
        verifyNoMoreInteractions(mockListPreviewRepository);
      });
    });

    final Stream<Either<ListPreviewFailure, List<ListPreview>>>
        listPreviewStream_insufficientPermissions =
        Stream<Either<ListPreviewFailure, List<ListPreview>>>.fromIterable(
            [Left(InsufficientPermissions())]);

    test("should return the same failure as repo (InsufficientPermissions)",
        () {
      //* arrange
      when(mockListPreviewRepository.watchAll())
          .thenAnswer((_) => listPreviewStream_insufficientPermissions);

      //* act
      final result = mockListPreviewRepository.watchAll();

      //* assert
      result.listen((element) {
        expect(element.isLeft(), true);

        element.fold((failure) => expect(failure, InsufficientPermissions()),
            (value) => expect(1, 2));

        // verify that method is called
        verify(mockListPreviewRepository.watchAll());
        // verify that class is called only used once
        verifyNoMoreInteractions(mockListPreviewRepository);
      });
    });


    final Stream<Either<ListPreviewFailure, List<ListPreview>>>
        listPreviewStream_unexpectedFailure =
        Stream<Either<ListPreviewFailure, List<ListPreview>>>.fromIterable(
            [Left(UnexpectedFailure())]);
    test("should return the same failure as repo (UnexpectedFailure)", () {
      //* arrange
      when(mockListPreviewRepository.watchAll())
          .thenAnswer((_) => listPreviewStream_unexpectedFailure);

      //* act
      final result = mockListPreviewRepository.watchAll();

      //* assert
      result.listen((element) {
        expect(element.isLeft(), true);

        element.fold((failure) => expect(failure, UnexpectedFailure()),
            (value) => expect(1, 2));

        // verify that method is called
        verify(mockListPreviewRepository.watchAll());
        // verify that class is called only used once
        verifyNoMoreInteractions(mockListPreviewRepository);
      });
    });

    final Stream<Either<ListPreviewFailure, List<ListPreview>>>
        listPreviewStream_unexpectedFailureFirebase =
        Stream<Either<ListPreviewFailure, List<ListPreview>>>.fromIterable(
            [Left(UnexpectedFailureFirebase())]);
    test("should return the same failure as repo (UnexpectedFailureFirebase)", () {
      //* arrange
      when(mockListPreviewRepository.watchAll())
          .thenAnswer((_) => listPreviewStream_unexpectedFailureFirebase);

      //* act
      final result = mockListPreviewRepository.watchAll();

      //* assert
      result.listen((element) {
        expect(element.isLeft(), true);

        element.fold((failure) => expect(failure, UnexpectedFailureFirebase()),
            (value) => expect(1, 2));

        // verify that method is called
        verify(mockListPreviewRepository.watchAll());
        // verify that class is called only used once
        verifyNoMoreInteractions(mockListPreviewRepository);
      });
    });
  });
}

// generate mock of classes specified in annotation
//! flutter packages run build_runner build --delete-conflicting-outputs