part of 'list_form_bloc.dart';

//TODO fetch data to users in group to show name and title. also fetch friends and show them too

class ListFormState {
  final ListData listData;
  final bool isFavorite;
  final bool showErrorMessages;
  final bool isSaving;
  final bool isEditing;
  final Option<Either<ListFailure, Unit>> failureOrSuccessOption;
  List<Friend> members;

  ListFormState({
    required this.listData,
    required this.isFavorite,
    required this.showErrorMessages,
    required this.isSaving,
    required this.isEditing,
    required this.failureOrSuccessOption,
    required this.members,
  });

  factory ListFormState.initial() => ListFormState(
        listData: ListData.empty(),
        isFavorite: false,
        showErrorMessages: false,
        isEditing: false,
        isSaving: false,
        failureOrSuccessOption: none(),
        members: [],
      );

  ListFormState copyWith({
    ListData? listData,
    bool? isFavorite,
    bool? showErrorMessages,
    bool? isSaving,
    bool? isEditing,
    Option<Either<ListFailure, Unit>>? failureOrSuccessOption,
    List<Friend>? members,
  }) {
    return ListFormState(
      listData: listData ?? this.listData,
      isFavorite: isFavorite ?? this.isFavorite,
      showErrorMessages: showErrorMessages ?? this.showErrorMessages,
      isSaving: isSaving ?? this.isSaving,
      isEditing: isEditing ?? this.isEditing,
      failureOrSuccessOption:
          failureOrSuccessOption ?? this.failureOrSuccessOption,
      members: members ?? this.members,
    );
  }
}
