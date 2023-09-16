part of 'add_item_form_bloc.dart';

class AddItemFormState {
  final bool showErrorMessages;
  final bool isSaving;
  final bool isEditing;
  final bool isDone;
  final Option<Either<ItemFailure, Unit>> failureOrSuccessOption;

  AddItemFormState({
    required this.showErrorMessages,
    required this.isEditing,
    required this.isSaving,
    required this.failureOrSuccessOption,
    required this.isDone,
  });

  factory AddItemFormState.initial() => AddItemFormState(
        showErrorMessages: false,
        isEditing: false,
        isSaving: false,
        failureOrSuccessOption: none(),
        isDone: false,
      );

  AddItemFormState copyWith({
    Item? item,
    bool? showErrorMessages,
    bool? isSaving,
    bool? isEditing,
    Option<Either<ItemFailure, Unit>>? failureOrSuccessOption,
    bool? isDone,
  }) {
    return AddItemFormState(
      showErrorMessages: showErrorMessages ?? this.showErrorMessages,
      isSaving: isSaving ?? this.isSaving,
      isEditing: isEditing ?? this.isEditing,
      failureOrSuccessOption:
          failureOrSuccessOption ?? this.failureOrSuccessOption,
      isDone: isDone ?? this.isDone,
    );
  }
}
