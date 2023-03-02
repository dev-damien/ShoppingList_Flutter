import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/material.dart';

class SignUpForm extends StatelessWidget {
  const SignUpForm({super.key});

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);

    return Form(
      child: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        children: [
          const SizedBox(
            height: 80,
          ),
          Text(
            "Welcome",
            style: themeData.textTheme.displayLarge!.copyWith(
              fontSize: 50,
              fontWeight: FontWeight.w500,
              letterSpacing: 4,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            "Please register or login",
            style: themeData.textTheme.displayLarge!.copyWith(
              fontSize: 20,
              fontWeight: FontWeight.w500,
              letterSpacing: 4,
            ),
          ),
          const SizedBox(
            height: 80,
          ),
          TextFormField(
            cursorColor: themeData.colorScheme.onPrimary,
            decoration: const InputDecoration(labelText: "E-Mail"),
          ),
          const SizedBox(
            height: 20,
          ),
          TextFormField(
            cursorColor: themeData.colorScheme.onPrimary,
            decoration: const InputDecoration(labelText: "Password"),
            obscureText: true,
          ),
        ],
      ),
    );
  }
}
