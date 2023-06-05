import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:struccleancrudexam/src/domain/usecases/firebase_usecases/user/get_single_other_user_usecase.dart';

import '../../../../domain/entities/user_entity.dart';

part 'get_single_other_user_event.dart';
part 'get_single_other_user_state.dart';

class GetSingleOtherUserBloc
    extends Bloc<GetSingleOtherUserEvent, GetSingleOtherUserState> {
  final GetSingleOtherUserUseCase getSingleOtherUserUseCase;
  GetSingleOtherUserBloc({required this.getSingleOtherUserUseCase})
      : super(GetSingleOtherUserInitialState()) {
    on<GetSingleOtherUser_Event>((event, emit) {
      // TODO: implement event handler
      emit(GetSingleOtherUserLoadingState());
      try {
        final streamResponse = getSingleOtherUserUseCase.call(event.otherUid);
        streamResponse.listen((users) {
          emit(GetSingleOtherUserLoadedState(otherUser: users.first));
        });
      } on SocketException catch (_) {
        emit(GetSingleOtherUserFailureState());
      } catch (_) {
        emit(GetSingleOtherUserFailureState());
      }
    });
  }
}
