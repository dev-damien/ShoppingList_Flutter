import 'package:dartz/dartz.dart';
import 'package:shoppinglist/03_domain/entities/list.dart';
import 'package:shoppinglist/03_domain/entities/list_preview.dart';
import 'package:shoppinglist/03_domain/repositories/auth_repository.dart';
import 'package:shoppinglist/03_domain/repositories/item_repository.dart';
import 'package:shoppinglist/03_domain/repositories/list_preview_repository.dart';
import 'package:shoppinglist/03_domain/repositories/list_repository.dart';
import 'package:shoppinglist/core/errors/errors.dart';
import 'package:shoppinglist/core/failures/list_failures.dart';
import 'package:shoppinglist/injection.dart';

class ListUsecases {
  final ListRepository listRepository;
  final ListPreviewRepository listPreviewRepository;
  final ItemRepository itemRepository;

  ListUsecases(
      {required this.listRepository,
      required this.listPreviewRepository,
      required this.itemRepository});

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
      ListData listNew, bool isFavorite) async {
    final userOption = sl<AuthRepository>().getSignedInUser();
    final user = userOption.getOrElse(() => throw NotAuthenticatedError());

    // get old list data
    final listOrFailure = await listRepository.get(listNew.id.value);
    listOrFailure.fold(
      (failure) {
        return left(failure);
      },
      (listOld) {
        // get all the members that will be removed from list
        final removedMembers = listOld.members
          ..removeWhere((element) => listNew.members.contains(element));

        // remove their list previews for this list
        for (var exMemberId in removedMembers) {
          listPreviewRepository.delete(exMemberId, listNew.id.value);
        }
      },
    );

    //BUG when user updates list, the isFav is set to false for all other members
    //? maybe create new classes for all models with all elements as optional to only update those
    //? or similar to the copy with method
    for (String memberId in listNew.members) {
      listPreviewRepository.update(
        memberId,
        ListPreview(
          id: listNew.id,
          title: listNew.title,
          imageId: listNew.imageId,
          isFavorite: memberId == user.id.value ? isFavorite : false,
        ),
      );
    }
    return listRepository.update(listNew);
  }

  //TODO if last user in group, delete it instead
  Future<Either<ListFailure, Unit>> leaveList(String listId) async {
    final userOption = sl<AuthRepository>().getSignedInUser();
    final user = userOption.getOrElse(() => throw NotAuthenticatedError());

    final listOrFailure = await listRepository.get(listId);

    await listOrFailure.fold(
      (failure) async {
        return left(failure);
      },
      (list) async {
        // remove list preview from user
        listPreviewRepository.delete(
          user.id.value,
          listId,
        );

        // remove user id from members
        list.members.remove(user.id.value);
        return await listRepository.update(list);

        //TODO ADMIN: if only admin, make other user new admin to avoid having no admin for a list
      },
    );
    return left(UnexpectedFailure());
  }

  Future<Either<ListFailure, Unit>> delete(String listId) async {
    final itemsOrFaiure = await listRepository.getItems(listId);
    final itemsBoughtOrFailure = await listRepository.getItemsBought(listId);

    //delete all items
    itemsOrFaiure.fold(
      (failure) {
        return left(failure);
      },
      (items) {
        for (var item in items) {
          itemRepository.delete(listId, item.id.value);
        }
      },
    );

    //delete all bought items
    itemsBoughtOrFailure.fold(
      (failure) {
        return left(failure);
      },
      (items) {
        for (var item in items) {
          itemRepository.delete(listId, item.id.value);
        }
      },
    );

    //delete list itself
    return listRepository.delete(listId);
  }
}
