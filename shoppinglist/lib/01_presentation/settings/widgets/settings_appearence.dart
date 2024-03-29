import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoppinglist/01_presentation/routes/router.gr.dart';
import 'package:shoppinglist/02_application/auth/authbloc/auth_bloc.dart';

class SettingsAppearence extends StatelessWidget {
  const SettingsAppearence({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    return MultiBlocListener(
      listeners: [
        BlocListener<AuthBloc, AuthState>(listener: (context, state) {
          if (state is AuthStateUnauthenticated) {
            AutoRouter.of(context).push(const SignUpPageRoute());
          }
        }),
      ],
      child: CupertinoListSection.insetGrouped(
        header: const Text('Appearence'),
        children: <CupertinoListTile>[
          CupertinoListTile.notched(
            title: const Text('Use system theme'),
            leading: const SizedBox(
              width: double.infinity,
              height: double.infinity,
              child: Icon(CupertinoIcons.arrow_2_circlepath),
            ),
            trailing: CupertinoSwitch(
              onChanged: (bool value) {},
              value: true,
            ),
          ),
          CupertinoListTile.notched(
              title: const Text('Darkmode'),
              leading: const SizedBox(
                width: double.infinity,
                height: double.infinity,
                child: Icon(CupertinoIcons.moon_zzz),
              ),
              trailing: CupertinoSwitch(
                onChanged: (bool value) {},
                value: isDark,
              ),
              onTap: () {
                //todo implement later if
              }
              // Navigator.of(context).push(
              //   CupertinoPageRoute<void>(
              //     builder: (BuildContext context) {
              //       return const HomePage();
              //     },
              //   ),
              // ),
              ),
        ],
      ),
    );
  }
}
