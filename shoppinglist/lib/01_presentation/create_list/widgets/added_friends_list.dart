import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoppinglist/01_presentation/create_list/widgets/added_friend_card.dart';
import 'package:shoppinglist/01_presentation/util/number_notification.dart';
import 'package:shoppinglist/02_application/lists/list_form/list_form_bloc.dart';

class AddedFriendsList extends StatelessWidget {
  const AddedFriendsList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ListFormBloc, ListFormState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Column(
          children: [
            Row(
              children: [
                const Text(
                  "Currently added users ",
                ),
                NumberNotification(number: state.members.length)
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            CupertinoScrollbar(
              child: SingleChildScrollView(
                physics: const ClampingScrollPhysics(),
                child: Builder(builder: (context) {
                  if (state.members.isEmpty) {
                    return const SizedBox();
                  }
                  return CupertinoListSection.insetGrouped(
                    topMargin: 0,
                    margin: const EdgeInsets.all(0),
                    children: List.generate(
                      state.members.length,
                      (index) {
                        final friend = state.members[index];
                        return AddedFriendCard(
                          friend: friend,
                          isMember: false,
                        );
                      },
                    ),
                  );
                }),
              ),
            ),
          ],
        );
      },
    );
  }
}
