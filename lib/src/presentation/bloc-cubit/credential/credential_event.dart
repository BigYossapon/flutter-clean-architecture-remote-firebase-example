part of 'credential_bloc.dart';

abstract class CredentialEvent extends Equatable {
  const CredentialEvent();

  @override
  List<Object> get props => [];
}

class SignInUserEvent extends CredentialEvent {
  final String? email;
  final String? password;
  SignInUserEvent(this.email, this.password);
  @override
  List<Object> get props => [];
}

class SignUpUserEvent extends CredentialEvent {
  final UserEntity userEntity;
  SignUpUserEvent({required this.userEntity});
  @override
  List<Object> get props => [userEntity];
}
