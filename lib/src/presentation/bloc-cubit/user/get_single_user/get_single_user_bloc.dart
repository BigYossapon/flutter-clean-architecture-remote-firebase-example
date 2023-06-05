import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:struccleancrudexam/src/domain/usecases/firebase_usecases/user/get_single_user_usecase.dart';
import 'package:struccleancrudexam/src/presentation/bloc-cubit/user/get_single_other_user/get_single_other_user_bloc.dart';

import '../../../../domain/entities/user_entity.dart';

part 'get_single_user_event.dart';
part 'get_single_user_state.dart';

class GetSingleUserBloc extends Bloc<GetSingleUserEvent, GetSingleUserState> {
  final GetSingleUserUseCase getSingleUserUseCase;
  GetSingleUserBloc({required this.getSingleUserUseCase})
      : super(GetSingleUserInitialState()) {
    on<GetSingleUser_Event>((event, emit) async* {
      // TODO: implement event handler
      yield (GetSingleUserLoadingState());
      try {
        final streamResponse = getSingleUserUseCase.call(event.uid);
        streamResponse.listen((user) async* {
          yield (GetSingleUserLoadedState(user: user));
        });
      } on SocketException catch (_) {
        yield (GetSingleUserFailureState());
      } catch (_) {
        yield (GetSingleUserFailureState());
      }
    });
  }
}
