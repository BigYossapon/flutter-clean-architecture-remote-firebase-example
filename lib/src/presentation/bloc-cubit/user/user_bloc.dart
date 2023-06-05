import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:struccleancrudexam/src/domain/entities/user_entity.dart';
import 'package:struccleancrudexam/src/domain/usecases/firebase_usecases/storage/upload_image_to_storage_usecase.dart';
import 'package:struccleancrudexam/src/domain/usecases/firebase_usecases/user/create_user_usecase.dart';
import 'package:struccleancrudexam/src/domain/usecases/firebase_usecases/user/delete_user_usecase.dart';

import '../../../domain/usecases/firebase_usecases/user/get_current_uid_usecase.dart';
import '../../../domain/usecases/firebase_usecases/user/get_users_usecase.dart';
import '../../../domain/usecases/firebase_usecases/user/update_user_usecase.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UpdateUserUseCase updateUserUseCase;
  final GetUsersUseCase getUsersUseCase;
  final DeleteUserUseCase deleteUserUseCase;
  final CreateUserUseCase createUserUseCase;
  final GetCurrentUidUseCase getCurrentUidUseCase;

  UserBloc({
    required this.updateUserUseCase,
    required this.getUsersUseCase,
    required this.deleteUserUseCase,
    required this.createUserUseCase,
    required this.getCurrentUidUseCase,
  }) : super(UserInitialState()) {
    on<GetUsersEvent>((event, emit) async {
      // TODO: implement event handler
      emit(UserLoadingState());
      try {
        final streamResponse = getUsersUseCase.call();
        streamResponse.listen((users) {
          emit(UserLoadedState(users: users));
        });
      } on SocketException catch (_) {
        emit(UserFailureState());
      } catch (_) {
        emit(UserFailureState());
      }
    });

    on<UpdateUserEvent>((event, emit) async {
      // TODO: implement event handler
      try {
        await updateUserUseCase.call(event.userEntity);
      } on SocketException catch (_) {
        emit(UserFailureState());
      } catch (_) {
        emit(UserFailureState());
      }
    });

    on<DeleteUserEvent>((event, emit) async {
      // TODO: implement event handler
      try {
        final uid = await getCurrentUidUseCase.call();
        await deleteUserUseCase.call(uid);
      } on SocketException catch (_) {
        emit(UserFailureState());
      } catch (_) {
        emit(UserFailureState());
      }
    });

    on<CreateUserEvent>((event, emit) async {
      // TODO: implement event handler
      try {
        final uid = await getCurrentUidUseCase.call();
        final userEntity = UserEntity(
            uid: uid,
            email: event.userEntity.email,
            password: event.userEntity.password);
        await createUserUseCase.call(event.userEntity);
      } on SocketException catch (_) {
        emit(UserFailureState());
      } catch (_) {
        emit(UserFailureState());
      }
    });
  }
}
