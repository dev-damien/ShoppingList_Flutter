import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shoppinglist/core/errors/errors.dart';
import 'package:shoppinglist/domain/repositories/auth_repository.dart';
import 'package:shoppinglist/injection.dart';

extension FirestoreExt on FirebaseFirestore {
  Future<DocumentReference> userDocument() async {
    final userOption = sl<AuthRepository>().getSignedInUser();
    final user = userOption.getOrElse(() => throw NotAuthenticatedError());

    return FirebaseFirestore.instance.collection("users").doc(user.id.value);
  }
}

extension DocumentReferenceExt on DocumentReference {
  CollectionReference<Map<String, dynamic>> get listPreviewCollection =>
      collection("lists_preview");
}

//TODO: maybe add extension for the lists as well
