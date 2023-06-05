part of 'user_bloc.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object> get props => [];
}

class GetUsersEvent extends UserEvent {
  @override
  List<Object> get props => [];
}

class UpdateUserEvent extends UserEvent {
  final UserEntity userEntity;
  UpdateUserEvent({required this.userEntity});
  @override
  List<Object> get props => [];
}

class CreateUserEvent extends UserEvent {
  final UserEntity userEntity;
  CreateUserEvent({required this.userEntity});
  @override
  List<Object> get props => [userEntity];
}

class DeleteUserEvent extends UserEvent {
  @override
  List<Object> get props => [];
}
