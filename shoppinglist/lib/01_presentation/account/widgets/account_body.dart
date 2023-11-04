import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoppinglist/01_presentation/account/widgets/profile_overview.dart';
import 'package:shoppinglist/01_presentation/account/widgets/settings_account.dart';
import 'package:shoppinglist/02_application/user/observer/user_observer_bloc.dart';
import 'package:shoppinglist/core/failures/user_failures.dart';

class AccountBody extends StatelessWidget {
  const AccountBody({super.key});

  String mapFailureMessage(UserFailure failure) {
    switch (failure.runtimeType) {
      case InsufficientPermissions:
        return "Your permissions are insufficient.";
      case UnexpectedFailure:
        return "An unexpected error occured. Try to restart the application.";
      case UnexpectedFailureFirebase:
        return "An unexpected error occured. This should not happen.";
      default:
        return "Something went wrong";
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserObserverBloc, UserObserverState>(
      builder: (context, state) {
        if (state is UserObserverInitial) {
          return Container();
        }
        if (state is UserObserverLoading) {
          return const CupertinoActivityIndicator();
        }
        if (state is UserObserverFailure) {
          return Center(
            child: Text(
              mapFailureMessage(
                state.userFailure,
              ),
            ),
          );
        }
        if (state is UserObserverSuccess) {
          return Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              ProfileOverview(
                userData: state.userData,
              ),
              const SettingsAccount(),
            ],
          );
        }
        return Container();
      },
    );
  }
}
