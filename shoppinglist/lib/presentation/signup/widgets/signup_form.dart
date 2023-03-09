import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoppinglist/application/auth/signupform/sign_up_form_bloc.dart';
import 'package:shoppinglist/core/failures/auth_failures.dart';
import 'package:shoppinglist/presentation/routes/router.gr.dart';
import 'package:shoppinglist/presentation/signup/widgets/signin_register_button.dart';

class SignUpForm extends StatelessWidget {
  const SignUpForm({super.key});

  @override
  Widget build(BuildContext context) {
    late String _email;
    late String _password;

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
        _email = input;
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
      _password = input;
      return null;
    }

    String mapFailureMessage(AuthFailure auth_failure) {
      switch (auth_failure.runtimeType) {
        case ServerFailure:
          return "Something went wrong";
        case EmailAlreadyInUseFailure:
          return "Email already in use";
        case InvalidEmailAndPasswordCombinationFailure:
          return "Invalid credentials";
        default:
          return "Something went wrong";
      }
    }

    final themeData = Theme.of(context);

    return BlocConsumer<SignUpFormBloc, SignUpFormState>(
      listenWhen: (previous, current) =>
          previous.authFailureOrSuccessOption !=
          current.authFailureOrSuccessOption,
      listener: (context, state) {
        state.authFailureOrSuccessOption.fold(
          () => {},
          (eitherFailureOrSuccess) => eitherFailureOrSuccess.fold(
            (failure) => {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(mapFailureMessage(failure),
                      style: themeData.textTheme.bodyLarge),
                  backgroundColor: Colors.redAccent,
                ),
              )
            },
            (success) => {
              AutoRouter.of(context).replace(
                const HomePageRoute(),
              )
            },
          ),
        );
      },
      builder: (context, state) {
        return Form(
          autovalidateMode: state.showValidationMessages
              ? AutovalidateMode.always
              : AutovalidateMode.disabled,
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
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                cursorColor: themeData.colorScheme.onPrimary,
                decoration: const InputDecoration(labelText: "Password"),
                obscureText: true,
                validator: validatePassword,
              ),
              const SizedBox(
                height: 40,
              ),
              SignInRegisterButton(
                buttonText: "Sign In",
                callback: () {
                  if (formKey.currentState!.validate()) {
                    BlocProvider.of<SignUpFormBloc>(context).add(
                        SignInWithEmailAndPasswordPressed(
                            email: _email, password: _password));
                  } else {
                    BlocProvider.of<SignUpFormBloc>(context).add(
                        SignInWithEmailAndPasswordPressed(
                            email: null, password: null));
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
                  if (formKey.currentState!.validate()) {
                    BlocProvider.of<SignUpFormBloc>(context).add(
                        RegisterWithEmailAndPasswordPressed(
                            email: _email, password: _password));
                  } else {
                    BlocProvider.of<SignUpFormBloc>(context).add(
                        RegisterWithEmailAndPasswordPressed(
                            email: null, password: null));
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
              if (state.isSubmitting) ...[
                const SizedBox(
                  height: 10,
                ),
                LinearProgressIndicator(
                  color: themeData.colorScheme.secondary,
                )
              ]
            ],
          ),
        );
      },
    );
  }
}
