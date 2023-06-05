import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/usecases/firebase_usecases/user/get_current_uid_usecase.dart';
import '../../../domain/usecases/firebase_usecases/user/is_sign_in_user_usecase.dart';
import '../../../domain/usecases/firebase_usecases/user/sign_out_usecase.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final SignOutUseCase signOutUseCase;
  final IsSignInUseCase isSignInUseCase;
  final GetCurrentUidUseCase getCurrentUidUseCase;
  AuthBloc(
      {required this.signOutUseCase,
      required this.isSignInUseCase,
      required this.getCurrentUidUseCase})
      : super(AuthInitialState()) {
    on<AppStartedEvent>((event, emit) async {
      // TODO: implement event handler
      try {
        bool isSignIn = await isSignInUseCase.call();
        if (isSignIn == true) {
          final uid = await getCurrentUidUseCase.call();
          emit(AuthenticatedState(uid: uid));
        } else {
          emit(UnAuthenticatedState());
        }
      } catch (_) {
        emit(UnAuthenticatedState());
      }
    });

    on<LoggedInEvent>((event, emit) async {
      // TODO: implement event handler
      try {
        final uid = await getCurrentUidUseCase.call();
        emit(AuthenticatedState(uid: uid));
      } catch (_) {
        emit(UnAuthenticatedState());
      }
    });

    on<LoggedOutEvent>((event, emit) async {
      // TODO: implement event handler
      try {
        await signOutUseCase.call();
        emit(UnAuthenticatedState());
      } catch (_) {
        emit(UnAuthenticatedState());
      }
    });
  }
}
