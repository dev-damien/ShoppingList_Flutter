import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoppinglist/02_application/auth/signupform/sign_up_form_bloc.dart';
import 'package:shoppinglist/injection.dart';
import 'package:shoppinglist/01_presentation/signup/widgets/signup_form.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: BlocProvider(
        create: (context) => sl<SignUpFormBloc>(),
        child: const SignUpForm(),
      ),
    );
  }
}
