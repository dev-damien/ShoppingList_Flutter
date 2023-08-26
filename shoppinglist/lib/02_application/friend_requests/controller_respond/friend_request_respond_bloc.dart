import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shoppinglist/03_domain/usecases/friend_usecases.dart';
import 'package:shoppinglist/core/enums/friend_request_responses.dart';
import 'package:shoppinglist/core/failures/friend_failures.dart';

part 'friend_request_respond_event.dart';
part 'friend_request_respond_state.dart';

class FriendRequestRespondBloc
    extends Bloc<FriendRequestRespondEvent, FriendRequestRespondState> {
  final FriendUsecases friendUsecases;

  FriendRequestRespondBloc({
    required this.friendUsecases,
  }) : super(FriendRequestRespondInitial()) {
    on<DeclineFriendRequestEvent>((event, emit) async {
      emit(
        FriendRequestRespondLoading(
          targetUserId: event.targetUserId,
          type: FriendRequestResponse.decline,
        ),
      );
      final failureOrSuccess =
          await friendUsecases.declineRequest(event.targetUserId);
      failureOrSuccess.fold(
        (failure) {
          emit(
            FriendRequestRespondFailure(
              targetUserId: event.targetUserId,
              type: FriendRequestResponse.decline,
              failure: failure,
            ),
          );
        },
        (success) {
          emit(
            FriendRequestRespondSuccess(
              targetUserId: event.targetUserId,
              type: FriendRequestResponse.decline,
            ),
          );
        },
      );
    });
    on<AcceptFriendRequestEvent>((event, emit) async {
      emit(
        FriendRequestRespondLoading(
          targetUserId: event.targetUserId,
          type: FriendRequestResponse.accept,
        ),
      );

      final failureOrSuccess =
          await friendUsecases.acceptRequest(event.targetUserId);
      failureOrSuccess.fold(
        (failure) {
          emit(
            FriendRequestRespondFailure(
              targetUserId: event.targetUserId,
              type: FriendRequestResponse.accept,
              failure: failure,
            ),
          );
        },
        (success) {
          emit(
            FriendRequestRespondSuccess(
              targetUserId: event.targetUserId,
              type: FriendRequestResponse.accept,
            ),
          );
        },
      );
    });
    on<BlockUserEvent>((event, emit) {
      emit(
        FriendRequestRespondLoading(
          targetUserId: event.targetUserId,
          type: FriendRequestResponse.block,
        ),
      );
      //TODO block user
      print(
          'friend_request_respond_bloc -> block user with id ${event.targetUserId}'); //TODO remove debug print
    });
  }
}
