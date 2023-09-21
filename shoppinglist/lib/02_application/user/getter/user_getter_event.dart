// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'user_getter_bloc.dart';

abstract class UserGetterEvent extends Equatable {
  const UserGetterEvent();

  @override
  List<Object> get props => [];
}

class GetUserByIdEvent extends UserGetterEvent {
  final String userId;

  const GetUserByIdEvent({
    required this.userId,
  });
}
