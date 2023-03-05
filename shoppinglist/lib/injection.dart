import 'package:get_it/get_it.dart';
import 'package:shoppinglist/application/auth/signupform/sign_up_form_bloc.dart';

final sl = GetIt.I; //service locator

Future<void> init() async {
  //! state management
  sl.registerFactory(() => SignUpFormBloc());
}