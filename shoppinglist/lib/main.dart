import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoppinglist/02_application/auth/authbloc/auth_bloc.dart';
import 'package:shoppinglist/02_application/friends/controller/friend_controller_bloc.dart';
import 'package:shoppinglist/02_application/friends/observer/friends_observer_bloc.dart';
import 'package:shoppinglist/02_application/items/controller/items_controller_bloc.dart';
import 'package:shoppinglist/02_application/items/observer/items_observer_bloc.dart';
import 'package:shoppinglist/02_application/lists/controller/list_controller_bloc.dart';
import 'package:shoppinglist/02_application/lists/list_form/list_form_bloc.dart';
import 'package:shoppinglist/02_application/user/observer/user_observer_bloc.dart';
import 'package:shoppinglist/firebase_options.dart';
import 'package:shoppinglist/injection.dart' as di;
import 'package:shoppinglist/01_presentation/routes/router.gr.dart' as r;

import '02_application/friend_requests/observer/friend_requests_observer_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final _appRouter = r.AppRouter();

  MyApp({super.key});

  // This widget is the root of the application.
  @override
  Widget build(BuildContext context) {
    // use only portrait
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              di.sl<AuthBloc>()..add(AuthCheckRequestedEvent()),
        ),
        BlocProvider(
          create: (context) =>
              di.sl<UserObserverBloc>()..add((ObserveUserEvent())),
        ),
        BlocProvider<FriendRequestsObserverBloc>(
          create: (context) => di.sl<FriendRequestsObserverBloc>()
            ..add(
              ObserveAllFriendRequestsEvent(),
            ),
        ),
        BlocProvider(
          create: (context) => di.sl<FriendControllerBloc>(),
        ),
        BlocProvider(
          create: (context) => di.sl<FriendsObserverBloc>()
            ..add(
              ObserveAllFriendsEvent(),
            ),
        ),
        BlocProvider(
          create: (context) => di.sl<ItemsObserverBloc>(),
        ),
        BlocProvider(
          create: (context) => di.sl<ItemsControllerBloc>(),
        ),
        BlocProvider(
          create: (context) => di.sl<ListFormBloc>(),
        ),
        BlocProvider(
          create: (context) => di.sl<ListControllerBloc>(),
        ),
      ],
      child: CupertinoApp.router(
        routeInformationParser: _appRouter.defaultRouteParser(),
        routerDelegate: _appRouter.delegate(),
        debugShowCheckedModeBanner: false,
        title: 'MinimaList',
        theme: const CupertinoThemeData(),
      ),
    );
  }
}
