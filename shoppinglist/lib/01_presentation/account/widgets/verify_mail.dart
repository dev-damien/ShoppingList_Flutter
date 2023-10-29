import 'package:flutter/cupertino.dart';
import 'package:shoppinglist/injection.dart';

class VerifyMailOverlay extends StatelessWidget {
  final bool isEmailAuthenticated;

  const VerifyMailOverlay({
    super.key,
    required this.isEmailAuthenticated,
  });

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: isEmailAuthenticated,
      child: Visibility(
          visible: !isEmailAuthenticated,
          child: Container(
            height: double.infinity,
            width: double.infinity,
            color: const Color.fromRGBO(0, 80, 157, 0.9),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
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
                CupertinoButton.filled(
                  child: const Text(
                    'Resend Verification Email',
                    style: TextStyle(
                      fontSize: 18,
                      color: CupertinoColors.white,
                    ),
                  ),
                  onPressed: () {
                    sendVerificationMail();
                  },
                ),
              ],
            ),
          )),
    );
  }

  sendVerificationMail() {
    
  }
}
