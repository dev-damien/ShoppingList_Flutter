import 'package:dartz/dartz.dart';
import 'package:shoppinglist/03_domain/entities/list.dart';
import 'package:shoppinglist/03_domain/entities/list_preview.dart';
import 'package:shoppinglist/03_domain/repositories/auth_repository.dart';
import 'package:shoppinglist/03_domain/repositories/list_preview_repository.dart';
import 'package:shoppinglist/03_domain/repositories/list_repository.dart';
import 'package:shoppinglist/core/errors/errors.dart';
import 'package:shoppinglist/core/failures/list_failures.dart';
import 'package:shoppinglist/injection.dart';

class ListUsecases {
  final ListRepository listRepository;
  final ListPreviewRepository listPreviewRepository;

  ListUsecases({
    required this.listRepository,
    required this.listPreviewRepository,
  });

  Stream<Either<ListFailure, ListData>> watch(String listId) {
    return listRepository.watch(listId);
  }

  Future<Either<ListFailure, Unit>> create(
      ListData list, bool isFavorite) async {
    final userOption = sl<AuthRepository>().getSignedInUser();
    final user = userOption.getOrElse(() => throw NotAuthenticatedError());
    for (String memberId in list.members) {
      listPreviewRepository.create(
        memberId,
        ListPreview(
          id: list.id,
          title: list.title,
          imageId: list.imageId,
          isFavorite: memberId == user.id.value ? isFavorite : false,
        ),
      );
    }
    return listRepository.create(list);
  }

  Future<Either<ListFailure, Unit>> update(
      ListData list, bool isFavorite) async {
    final userOption = sl<AuthRepository>().getSignedInUser();
    final user = userOption.getOrElse(() => throw NotAuthenticatedError());
    for (String memberId in list.members) {
      listPreviewRepository.update(
        memberId,
        ListPreview(
          id: list.id,
          title: list.title,
          imageId: list.imageId,
          isFavorite: memberId == user.id.value ? isFavorite : false,
        ),
      );
    }
    return listRepository.update(list);
  }

  Future<Either<ListFailure, Unit>> delete(String listId) {
    return listRepository.delete(listId);
  }
}
