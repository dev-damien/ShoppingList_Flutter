import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoppinglist/02_application/auth/authbloc/auth_bloc.dart';
import 'package:shoppinglist/firebase_options.dart';
import 'package:shoppinglist/injection.dart' as di;
import 'package:shoppinglist/01_presentation/routes/router.gr.dart' as r;

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
        )
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
