import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/entities/user_entity.dart';
import '../../../domain/usecases/firebase_usecases/user/sign_in_user_usecase.dart';
import '../../../domain/usecases/firebase_usecases/user/sign_up_user_usecase.dart';

part 'credential_event.dart';
part 'credential_state.dart';

class CredentialBloc extends Bloc<CredentialEvent, CredentialState> {
  final SignInUserUseCase signInUserUseCase;
  final SignUpUserUseCase signUpUserUseCase;

  CredentialBloc(
      {required this.signInUserUseCase, required this.signUpUserUseCase})
      : super(CredentialInitialState()) {
    on<SignInUserEvent>((event, emit) async {
      // TODO: implement event handler
      emit(CredentialLoadingState());
      try {
        await signInUserUseCase
            .call(UserEntity(email: event.email, password: event.password));

        emit(CredentialSuccessState(""));
      } on SocketException catch (_) {
        emit(CredentialFailureState());
      } catch (_) {
        emit(CredentialFailureState());
      }
    });

    on<SignUpUserEvent>((event, emit) async {
      // TODO: implement event handler
      emit(CredentialLoadingState());
      try {
        final uid = await signUpUserUseCase.call(event.userEntity);
        emit(CredentialSuccessState(uid));
      } on SocketException catch (_) {
        emit(CredentialFailureState());
      } catch (_) {
        emit(CredentialFailureState());
      }
    });
  }
}
