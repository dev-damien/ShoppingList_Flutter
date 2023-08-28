import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shoppinglist/02_application/add_friends/searchForm/friend_search_form_bloc.dart';
import 'package:shoppinglist/02_application/auth/authbloc/auth_bloc.dart';
import 'package:shoppinglist/02_application/auth/signupform/sign_up_form_bloc.dart';
import 'package:shoppinglist/02_application/friend_requests/controller_respond/friend_request_respond_bloc.dart';
import 'package:shoppinglist/02_application/friend_requests/controller_send/friend_request_controller_bloc.dart';
import 'package:shoppinglist/02_application/friends/controller/friend_controller_bloc.dart';
import 'package:shoppinglist/02_application/friends/observer/friends_observer_bloc.dart';
import 'package:shoppinglist/02_application/items/observer/items_observer_bloc.dart';
import 'package:shoppinglist/02_application/list_previews/observer/observer_bloc.dart';
import 'package:shoppinglist/02_application/lists/addingMode/list_add_items_mode_bloc.dart';
import 'package:shoppinglist/02_application/lists/observer/list_observer_bloc.dart';
import 'package:shoppinglist/02_application/user/observer/user_observer_bloc.dart';
import 'package:shoppinglist/03_domain/repositories/auth_repository.dart';
import 'package:shoppinglist/03_domain/repositories/friend_repository.dart';
import 'package:shoppinglist/03_domain/repositories/item_repository.dart';
import 'package:shoppinglist/03_domain/repositories/list_preview_repository.dart';
import 'package:shoppinglist/03_domain/repositories/list_repository.dart';
import 'package:shoppinglist/03_domain/repositories/user_repository.dart';
import 'package:shoppinglist/03_domain/usecases/auth_usecases.dart';
import 'package:shoppinglist/03_domain/usecases/friend_usecases.dart';
import 'package:shoppinglist/03_domain/usecases/item_usecases.dart';
import 'package:shoppinglist/03_domain/usecases/list_preview_usecases.dart';
import 'package:shoppinglist/03_domain/usecases/list_usecases.dart';
import 'package:shoppinglist/03_domain/usecases/user_usecases.dart';
import 'package:shoppinglist/04_infrastructure/repositories/auth_repository_impl.dart';
import 'package:shoppinglist/04_infrastructure/repositories/friend_repository_impl.dart';
import 'package:shoppinglist/04_infrastructure/repositories/item_repository_impl.dart';
import 'package:shoppinglist/04_infrastructure/repositories/list_preview_repository_impl.dart';
import 'package:shoppinglist/04_infrastructure/repositories/list_repository_impl.dart';
import 'package:shoppinglist/04_infrastructure/repositories/user_repository_impl.dart';

import '02_application/friend_requests/observer/friend_requests_observer_bloc.dart';
import '04_infrastructure/local/theme_local_storage.dart';

final sl = GetIt.I; //service locator

Future<void> init() async {
  //? ################# local ###############################################################################

  //! datasource
  sl.registerLazySingleton<ThemeLocalDatasource>(
    () => ThemeLocalDatasourceImpl(
      sharedPreferences: sl(),
    ),
  );

  //! extern
  final sharedPrefernces = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPrefernces);

  //? ################# auth ###############################################################################
  //! state management
  sl.registerFactory(
    () => SignUpFormBloc(
      authUsecases: sl(),
    ),
  );
  sl.registerFactory(
    () => AuthBloc(
      authUsecases: sl(),
    ),
  );

  //! usecases
  sl.registerLazySingleton<AuthUsecases>(
    () => AuthUsecases(
      authRepository: sl(),
    ),
  );

  //! repos
  sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(
        firebaseAuth: sl(),
        firestore: sl(),
      ));

  //? ################ user ###############################################################################

  //! state management
  sl.registerFactory(
    () => UserObserverBloc(
      userUsecases: sl(),
    ),
  );

  //! usecases
  sl.registerLazySingleton(
    () => UserUsecases(
      userRepository: sl(),
    ),
  );

  //! repos
  sl.registerLazySingleton<UserRepository>(
    () => UserRepositoryImpl(
      firestore: sl(),
    ),
  );

  //? ################ lists ###############################################################################

  //! state management
  sl.registerFactory(
    () => ObserverBloc(
      listPreviewUsecases: sl(),
    ),
  );
  sl.registerFactory(
    () => ListObserverBloc(
      listUsecases: sl(),
    ),
  );
  sl.registerFactory(
    () => ListAddItemsModeBloc(),
  );

  //! usecases
  sl.registerLazySingleton(
    () => ListPreviewUsecases(
      listPreviewRepository: sl(),
    ),
  );
  sl.registerLazySingleton(
    () => ListUsecases(
      listRepository: sl(),
    ),
  );

  //! repos
  sl.registerLazySingleton<ListPreviewRepository>(
    () => ListPreviewRepositoryImpl(
      firestore: sl(),
    ),
  );
  sl.registerLazySingleton<ListRepository>(
    () => ListRepositoryImpl(
      firestore: sl(),
    ),
  );

  //? ################# friends and requests #####################################################################
  //! state management
  sl.registerFactory(
    () => FriendsObserverBloc(
      friendUsecases: sl(),
    ),
  );
  sl.registerFactory(
    () => FriendRequestsObserverBloc(
      friendUsecases: sl(),
      userUsecases: sl(),
    ),
  );
  sl.registerFactory(
    () => FriendSearchFormBloc(
      friendUsecases: sl(),
    ),
  );
  sl.registerFactory(
    () => FriendRequestControllerBloc(
      friendUsecases: sl(),
    ),
  );
  sl.registerFactory(
    () => FriendControllerBloc(
      friendUsecases: sl(),
    ),
  );
  sl.registerFactory(
    () => FriendRequestRespondBloc(
      friendUsecases: sl(),
    ),
  );

  //! usecases
  sl.registerLazySingleton(
    () => FriendUsecases(
      friendRepository: sl(),
      userRepository: sl(),
    ),
  );

  //! repos
  sl.registerLazySingleton<FriendRepository>(() => FriendRepositoryImpl(
        firestore: sl(),
        userRepository: sl(),
      ));

  //? ################# friends and requests #####################################################################

  //! state management
  sl.registerFactory(
    () => ItemsObserverBloc(
      itemUsecases: sl(),
    ),
  );

  //! usecases
  sl.registerLazySingleton(
    () => ItemUsecases(
      itemRepository: sl(),
    ),
  );

  //! repos
  sl.registerLazySingleton<ItemRepository>(
    () => ItemRepositoryImpl(
      firestore: sl(),
    ),
  );

  //! ################# external: firebase and firestore #####################################################################
  //! auth
  final firebaseAuth = FirebaseAuth.instance;
  sl.registerLazySingleton(
    () => firebaseAuth,
  );

  //! firestore
  final firestore = FirebaseFirestore.instance;
  sl.registerLazySingleton(
    () => firestore,
  );
}
