import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:shoppinglist/02_application/auth/authbloc/auth_bloc.dart';
import 'package:shoppinglist/02_application/auth/signupform/sign_up_form_bloc.dart';
import 'package:shoppinglist/02_application/list_previews/observer/observer_bloc.dart';
import 'package:shoppinglist/03_domain/repositories/auth_repository.dart';
import 'package:shoppinglist/03_domain/repositories/list_preview_repository.dart';
import 'package:shoppinglist/03_domain/usecases/auth_usecases.dart';
import 'package:shoppinglist/03_domain/usecases/list_preview_usecases.dart';
import 'package:shoppinglist/04_infrastructure/repositories/auth_repository_impl.dart';
import 'package:shoppinglist/04_infrastructure/repositories/list_preview_repository_impl.dart';

final sl = GetIt.I; //service locator

Future<void> init() async {
  //? ################# auth ####################
  //! state management
  sl.registerFactory(() => SignUpFormBloc(authUsecases: sl()));
  sl.registerFactory(() => AuthBloc(authUsecases: sl()));

  //! usecases
  sl.registerLazySingleton<AuthUsecases>(
      () => AuthUsecases(authRepository: sl()));

  //! repos
  sl.registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(firebaseAuth: sl()));

  //! extern
  final firebaseAuth = FirebaseAuth.instance;
  sl.registerLazySingleton(() => firebaseAuth);

  //? ################ lists ###############################################################################

  //! state management
  sl.registerFactory(() => ObserverBloc(listPreviewUsecases: sl()));

  //! usecases
  sl.registerLazySingleton(
      () => ListPreviewUsecases(listPreviewRepository: sl()));

  //! repos
  sl.registerLazySingleton<ListPreviewRepository>(
      () => ListPreviewRepositoryImpl(firestore: sl()));

  //! external
  final firestore = FirebaseFirestore.instance;
  sl.registerLazySingleton(() => firestore);
}
