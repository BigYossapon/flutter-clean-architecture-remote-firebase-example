part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthInitialState extends AuthState {
  @override
  List<Object> get props => [];
}

class AuthenticatedState extends AuthState {
  final String uid;

  AuthenticatedState({required this.uid});
  @override
  List<Object> get props => [uid];
}

class UnAuthenticatedState extends AuthState {
  @override
  List<Object> get props => [];
}
