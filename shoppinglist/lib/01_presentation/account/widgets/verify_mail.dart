import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoppinglist/02_application/auth/authbloc/auth_bloc.dart';
import 'package:shoppinglist/02_application/verification/userVerification/user_verification_bloc.dart';
import 'package:shoppinglist/injection.dart';

class VerifyMailOverlay extends StatelessWidget {
  final bool isEmailAuthenticated;

  const VerifyMailOverlay({
    super.key,
    required this.isEmailAuthenticated,
  });

  @override
  Widget build(BuildContext context) {
    //refresh userdata all 3 seconds to see if user is verified
    final refreshTimer = Timer.periodic(const Duration(seconds: 3), (Timer t) {
      sl<FirebaseAuth>().currentUser?.reload();
    });
    return IgnorePointer(
      ignoring: isEmailAuthenticated,
      child: Visibility(
        visible: !isEmailAuthenticated,
        child: Container(
          height: double.infinity,
          width: double.infinity,
          color: const Color.fromRGBO(0, 80, 157, 1),
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 40,
                ),
                const Text(
                  'Email verification required',
                  style: TextStyle(color: CupertinoColors.white, fontSize: 24),
                ),
                const Padding(
                  padding: EdgeInsets.all(21.0),
                  child: Text(
                    'To access all features, please verify your email by clicking the verification link we sent to your inbox.\nIf you need assistance or haven\'t received the email, contact our support.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                      color: CupertinoColors.white,
                      height: 1.4,
                      fontWeight: FontWeight.normal,
                      letterSpacing: 0.5,
                      fontFamily: 'Helvetica',
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                BlocBuilder<UserVerificationBloc, UserVerificationState>(
                  builder: (context, state) {
                    if (state is UserVerificationInProgress) {
                      return const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Sending new verification mail ...',
                            style: TextStyle(
                              color: CupertinoColors.white,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          CupertinoActivityIndicator(
                            color: CupertinoColors.white,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                        ],
                      );
                    }
                    if (state is UserVerificationFailure) {
                      return const Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            Icon(
                              Icons.error,
                              color: CupertinoColors.destructiveRed,
                              size: 42,
                            ),
                            Text(
                              'Verification email sending is temporarily unavailable. Please try again later.',
                              style: TextStyle(
                                color: CupertinoColors.white,
                                fontSize: 18,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      );
                    }
                    if (state is UserVerificationSuccess) {
                      return const Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            Icon(
                              Icons.mark_email_read_rounded,
                              color: CupertinoColors.activeGreen,
                              size: 42,
                            ),
                            Text(
                              'Success! We have resent the verification email to your inbox. Please check your email and follow the link to complete the verification process.',
                              style: TextStyle(
                                fontSize: 18,
                                color: CupertinoColors.white,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      );
                    }
                    return const SizedBox();
                  },
                ),
                CupertinoButton.filled(
                  child: const Text(
                    'Resend Verification Email',
                    style: TextStyle(
                      fontSize: 18,
                      color: CupertinoColors.white,
                    ),
                  ),
                  onPressed: () {
                    // send verification mail to user
                    BlocProvider.of<UserVerificationBloc>(context)
                        .add(sendVerificationMail());
                  },
                ),
                Expanded(
                  child: CupertinoButton(
                    alignment: Alignment.bottomCenter,
                    child: const Text(
                      'Logout',
                      style: TextStyle(
                        color: CupertinoColors.lightBackgroundGray,
                      ),
                    ),
                    onPressed: () => BlocProvider.of<AuthBloc>(context).add(
                      SignOutPressedEvent(),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
