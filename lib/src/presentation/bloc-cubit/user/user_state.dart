part of 'user_bloc.dart';

abstract class UserState extends Equatable {
  const UserState();

  @override
  List<Object> get props => [];
}

class UserInitialState extends UserState {
  @override
  List<Object> get props => [];
}

class UserLoadingState extends UserState {
  @override
  List<Object> get props => [];
}

class UserLoadedState extends UserState {
  final List<UserEntity> users;

  UserLoadedState({required this.users});
  @override
  List<Object> get props => [users];
}

class UserFailureState extends UserState {
  @override
  List<Object> get props => [];
}
