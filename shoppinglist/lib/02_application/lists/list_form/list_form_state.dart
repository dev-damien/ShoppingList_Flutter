part of 'list_form_bloc.dart';

class ListFormState {
  final ListData listData;
  final bool isFavorite;
  final bool showErrorMessages;
  final bool isSaving;
  final bool isEditing;
  final Option<Either<ListFailure, Unit>> failureOrSuccessOption;

  const ListFormState({
    required this.listData,
    required this.isFavorite,
    required this.showErrorMessages,
    required this.isSaving,
    required this.isEditing,
    required this.failureOrSuccessOption,
  });

  factory ListFormState.initial() => ListFormState(
      listData: ListData.empty(),
      isFavorite: false,
      showErrorMessages: false,
      isEditing: false,
      isSaving: false,
      failureOrSuccessOption: none());

  ListFormState copyWith({
    ListData? listData,
    bool? isFavorite,
    bool? showErrorMessages,
    bool? isSaving,
    bool? isEditing,
    Option<Either<ListFailure, Unit>>? failureOrSuccessOption,
  }) {
    return ListFormState(
      listData: listData ?? this.listData,
      isFavorite: isFavorite ?? this.isFavorite,
      showErrorMessages: showErrorMessages ?? this.showErrorMessages,
      isSaving: isSaving ?? this.isSaving,
      isEditing: isEditing ?? this.isEditing,
      failureOrSuccessOption:
          failureOrSuccessOption ?? this.failureOrSuccessOption,
    );
  }
}
