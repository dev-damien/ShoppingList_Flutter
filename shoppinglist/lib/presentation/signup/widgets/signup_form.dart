import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/material.dart';
import 'package:shoppinglist/presentation/signup/widgets/signin_register_button.dart';

class SignUpForm extends StatelessWidget {
  const SignUpForm({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();

    //just a very simple validation that checks for the basic structure of the provided mail
    //should be x@y.z with x,y,z beeing any strings
    //will also match with some invalid inputs, but its for user convenience, not security
    String? validateEmail(String? input) {
      const emailRegex =
          r"""^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+""";

      if (input == null || input.isEmpty) {
        return "Please enter email";
      }
      if (RegExp(emailRegex).hasMatch(input)) {
        return null;
      }
      return "Invalid email format";
    }

    String? validatePassword(String? input) {
      if (input == null || input.isEmpty) {
        return "Please enter password";
      }
      if (input.length < 6) {
        return "Password is too short";
      }
      return null;
    }

    final themeData = Theme.of(context);

    return Form(
      key: formKey,
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
            validator: validateEmail,
            autovalidateMode: AutovalidateMode.disabled,
          ),
          const SizedBox(
            height: 20,
          ),
          TextFormField(
            cursorColor: themeData.colorScheme.onPrimary,
            decoration: const InputDecoration(labelText: "Password"),
            obscureText: true,
            validator: validatePassword,
            autovalidateMode: AutovalidateMode.disabled,
          ),
          const SizedBox(
            height: 40,
          ),
          SignInRegisterButton(
            buttonText: "Sign In",
            callback: () {
              print("sign in clicked");
              if (formKey.currentState!.validate()) {
                print("validated");
              } else {
                print("unvalid");
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("Invalid input",
                        style: themeData.textTheme.bodyLarge),
                    backgroundColor: Colors.redAccent,
                  ),
                );
              }
            },
          ),
          const SizedBox(
            height: 20,
          ),
          SignInRegisterButton(
            buttonText: "Register",
            callback: () {
              print("register button clicked");
            },
          ),
        ],
      ),
    );
  }
}
