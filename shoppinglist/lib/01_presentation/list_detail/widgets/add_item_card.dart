import 'package:flutter/cupertino.dart';

class AddItemCard extends StatelessWidget {
  const AddItemCard({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoListSection(
      margin: EdgeInsets.all(0),
      topMargin: 0,
      children: [
        CupertinoListTile.notched(
          leadingSize: double.parse('42.0'),
          leading: SizedBox(
            width: 100,
            child: CupertinoTextField(
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number,
              placeholder: '1',
            ),
          ),
          title: CupertinoTextField(
            keyboardType: TextInputType.text,
            placeholder: 'Enter item ...',
          ),
          trailing: CupertinoButton(
            child: Icon(CupertinoIcons.arrow_right_circle_fill),
            onPressed: () {},
          ),
        ),
      ],
    );
  }
}
