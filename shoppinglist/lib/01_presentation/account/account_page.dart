import 'package:flutter/cupertino.dart';
import 'package:shoppinglist/01_presentation/account/widgets/account_body.dart';
import 'package:shoppinglist/01_presentation/settings/widgets/settings_body.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('Account'),
      ),
      child: Container(
        height: double.infinity,
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: SafeArea(
            child: AccountBody(),
          ),
        ),
      ),
    );
  }
}
