import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoppinglist/02_application/items/add_form/add_item_form_bloc.dart';
import 'package:shoppinglist/03_domain/entities/item.dart';
import 'package:shoppinglist/injection.dart';

class AddItemCard extends StatefulWidget {
  final Item? item;
  final String listId;

  const AddItemCard({
    Key? key,
    required this.item,
    required this.listId,
  }) : super(key: key);

  @override
  _AddItemCardState createState() => _AddItemCardState();
}

class _AddItemCardState extends State<AddItemCard> {
  late final TextEditingController numberController;
  late final TextEditingController titleController;
  late final AddItemFormBloc _addItemFormBloc;
  late final FocusNode _titleFocusNode;

  @override
  void initState() {
    super.initState();
    numberController = TextEditingController();
    titleController = TextEditingController();
    _addItemFormBloc = sl<AddItemFormBloc>();
    _titleFocusNode = FocusNode();
  }

  @override
  void dispose() {
    numberController.dispose();
    titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Move focus to title input field
    _titleFocusNode.requestFocus();

    return BlocProvider.value(
      value: _addItemFormBloc,
      child: BlocConsumer<AddItemFormBloc, AddItemFormState>(
        listener: (context, state) {
          if (state.isDone) {
            _addItemFormBloc.add(InitializeItemAddFormEvent());

            //reset text in both fields
            titleController.clear();
            numberController.clear();

            // Move focus to title input field
            _titleFocusNode.requestFocus();
          }
        },
        builder: (context, state) {
          return CupertinoListSection(
            margin: const EdgeInsets.all(0),
            topMargin: 0,
            children: [
              CupertinoListTile.notched(
                leadingSize: double.parse('42.0'),
                leading: state.isSaving
                    ? const SizedBox(
                        height: 0,
                      )
                    : SizedBox(
                        width: 100,
                        child: CupertinoTextField(
                          controller: numberController,
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.number,
                          placeholder: '1',
                        ),
                      ),
                title: state.isSaving
                    ? const Center(
                        child: CupertinoActivityIndicator(),
                      )
                    : CupertinoTextField(
                        controller: titleController,
                        focusNode: _titleFocusNode,
                        key: const Key('itemTitleInput'),
                        keyboardType: TextInputType.text,
                        placeholder: 'Enter item ...',
                        minLines: 1,
                        maxLines: 2,
                        maxLength: 42,
                      ),
                trailing: state.isSaving
                    ? const SizedBox(
                        height: 0,
                      )
                    : CupertinoButton(
                        child:
                            const Icon(CupertinoIcons.arrow_right_circle_fill),
                        onPressed: () {
                          int numberValue = numberController.text.isEmpty
                              ? 1
                              : int.parse(numberController.text);
                          String titleValue = titleController.text;
                          _addItemFormBloc.add(
                            SafePressedEvent(
                              listId: widget.listId,
                              number: numberValue,
                              title: titleValue,
                            ),
                          );
                        },
                      ),
              ),
            ],
          );
        },
      ),
    );
  }
}
