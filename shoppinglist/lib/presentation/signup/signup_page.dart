import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoppinglist/application/auth/signupform/sign_up_form_bloc.dart';
import 'package:shoppinglist/injection.dart';
import 'package:shoppinglist/presentation/signup/widgets/signup_form.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => sl<SignUpFormBloc>(),
        child: const SignUpForm(),
      ),
    );
  }
}
