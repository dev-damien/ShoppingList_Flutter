import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoppinglist/application/auth/authbloc/auth_bloc.dart';
import 'package:shoppinglist/application/list_previews/observer/observer_bloc.dart';
import 'package:shoppinglist/injection.dart';
import 'package:shoppinglist/presentation/home/widgets/home_body.dart';
import 'package:shoppinglist/presentation/routes/router.gr.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final observerBloc = sl<ObserverBloc>()..add(ObserveAllEvent());
    return MultiBlocProvider(
      providers: [
        BlocProvider<ObserverBloc>(
          create: (context) => observerBloc,
        ),
      ],
      child: MultiBlocListener(
        listeners: [
          BlocListener<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state is AuthStateUnauthenticated) {
                AutoRouter.of(context).push(const SignUpPageRoute());
              }
            },
          )
        ],
        child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(Icons.logout),
              onPressed: () {
                //use this wherever needed to logout
                BlocProvider.of<AuthBloc>(context).add(
                  SignOutPressedEvent(),
                );
              },
            ),
            title: const Text("Lists"),
          ),
          body: const HomeBody(),
        ),
      ),
    );
  }
}
