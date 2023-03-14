import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:shoppinglist/application/auth/authbloc/auth_bloc.dart';
import 'package:shoppinglist/application/auth/signupform/sign_up_form_bloc.dart';
import 'package:shoppinglist/application/list_previews/observer/observer_bloc.dart';
import 'package:shoppinglist/domain/repositories/auth_repository.dart';
import 'package:shoppinglist/domain/repositories/list_preview_repository.dart';
import 'package:shoppinglist/infrastructure/repositories/auth_repository_impl.dart';
import 'package:shoppinglist/infrastructure/repositories/list_preview_repository_impl.dart';

final sl = GetIt.I; //service locator

Future<void> init() async {
  //? ################# auth ####################
  //! state management
  sl.registerFactory(() => SignUpFormBloc(authRepository: sl()));
  sl.registerFactory(() => AuthBloc(authRepository: sl()));

  //! repos
  sl.registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(firebaseAuth: sl()));

  //! extern
  final firebaseAuth = FirebaseAuth.instance;
  sl.registerLazySingleton(() => firebaseAuth);

  //? ################# lists ####################

  //! state management
  sl.registerFactory(() => ObserverBloc(listPreviewRepository: sl()));

  //! repos
  sl.registerLazySingleton<ListPreviewRepository>(
      () => ListPreviewRepositoryImpl(firestore: sl()));

  //! external
  final firestore = FirebaseFirestore.instance;
  sl.registerLazySingleton(() => firestore);
}
