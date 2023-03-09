import 'package:auto_route/auto_route.dart';
import 'package:shoppinglist/presentation/home/home_page.dart';
import 'package:shoppinglist/presentation/signup/signup_page.dart';
import 'package:shoppinglist/presentation/splash/splash_page.dart';

@MaterialAutoRouter(
  routes: <AutoRoute>[
    AutoRoute(page: SplashPage, initial: true),
    AutoRoute(page: SignUpPage, initial: false),
    AutoRoute(page: HomePage, initial: false)
  ],
)
class $AppRouter {}

// command to generate code
// flutter packages pub run build_runner build
