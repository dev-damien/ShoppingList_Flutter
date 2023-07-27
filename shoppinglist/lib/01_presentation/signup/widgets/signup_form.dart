import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoppinglist/02_application/auth/signupform/sign_up_form_bloc.dart';
import 'package:shoppinglist/core/failures/auth_failures.dart';
import 'package:shoppinglist/01_presentation/routes/router.gr.dart';

class SignUpForm extends StatelessWidget {
  const SignUpForm({super.key});

  @override
  Widget build(BuildContext context) {
    String? _emailInput;
    String? _passwordInput;
    String? _email;
    String? _password;

    final GlobalKey<FormState> formKey = GlobalKey<FormState>();

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

    String mapFailureMessage(AuthFailure authFailure) {
      switch (authFailure.runtimeType) {
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

    void _showCupertinoDialog(String title, String message) {
      showCupertinoDialog(
        context: context,
        builder: (context) => CupertinoAlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            CupertinoDialogAction(
              child: const Text('OK'),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        ),
      );
    }

    final themeData = CupertinoTheme.of(context);

    return BlocConsumer<SignUpFormBloc, SignUpFormState>(
      listenWhen: (previous, current) =>
          previous.authFailureOrSuccessOption !=
          current.authFailureOrSuccessOption,
      listener: (context, state) {
        state.authFailureOrSuccessOption.fold(
          () {},
          (eitherFailureOrSuccess) => eitherFailureOrSuccess.fold(
            (failure) {
              showCupertinoDialog(
                context: context,
                builder: (context) => CupertinoAlertDialog(
                  title: const Text('Error'),
                  content: Text(mapFailureMessage(failure)),
                  actions: [
                    CupertinoDialogAction(
                      child: const Text('OK'),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
              );
            },
            (success) {
              AutoRouter.of(context).replace(const HomePageRoute());
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
                style: themeData.textTheme.navTitleTextStyle.copyWith(
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
                style: themeData.textTheme.textStyle.copyWith(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 4,
                ),
              ),
              const SizedBox(
                height: 80,
              ),
              CupertinoTextField(
                decoration: BoxDecoration(
                  border: Border.all(color: CupertinoColors.activeBlue),
                  borderRadius: BorderRadius.circular(8),
                ),
                placeholder: 'E-Mail',
                onChanged: (input) {
                  _emailInput = input;
                  validateEmail(input);
                },
                // validator: validateEmail,
              ),
              const SizedBox(
                height: 20,
              ),
              CupertinoTextField(
                cursorColor: themeData.primaryColor,
                decoration: BoxDecoration(
                  border: Border.all(color: CupertinoColors.activeBlue),
                  borderRadius: BorderRadius.circular(8),
                ),
                placeholder: 'Password',
                obscureText: true,
                onChanged: (input) {
                  validatePassword(input);
                  _passwordInput = input;
                },
                // validator: validatePassword,
              ),
              const SizedBox(
                height: 40,
              ),
              CupertinoButton.filled(
                child: Text("Sign In"),
                onPressed: () {
                  if (_email != null && _password != null) {
                    BlocProvider.of<SignUpFormBloc>(context).add(
                      SignInWithEmailAndPasswordPressed(
                        email: _email,
                        password: _password,
                      ),
                    );
                  } else {
                    BlocProvider.of<SignUpFormBloc>(context).add(
                      SignInWithEmailAndPasswordPressed(
                        email: null,
                        password: null,
                      ),
                    );
                    String message = validateEmail(_emailInput) ?? validatePassword(_passwordInput)?? "Unexpected Error";
                    _showCupertinoDialog("Information", message);
                  }
                },
              ),
              const SizedBox(
                height: 20,
              ),
              CupertinoButton.filled(
                child: Text("Register"),
                onPressed: () {
                  if (_email != null && _password != null) {
                    BlocProvider.of<SignUpFormBloc>(context).add(
                      RegisterWithEmailAndPasswordPressed(
                        email: _email,
                        password: _password,
                      ),
                    );
                  } else {
                    BlocProvider.of<SignUpFormBloc>(context).add(
                      RegisterWithEmailAndPasswordPressed(
                        email: null,
                        password: null,
                      ),
                    );
                    //String title = validateEmail(_email);
                    _showCupertinoDialog("", "");
                  }
                },
              ),
              if (state.isSubmitting) ...[
                const SizedBox(
                  height: 10,
                ),
                const CupertinoActivityIndicator(),
              ],
            ],
          ),
        );
      },
    );
  }
}
