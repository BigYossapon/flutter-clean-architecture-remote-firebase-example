part of 'credential_bloc.dart';

abstract class CredentialState extends Equatable {
  const CredentialState();

  @override
  List<Object> get props => [];
}

class CredentialInitialState extends CredentialState {
  @override
  List<Object> get props => [];
}

class CredentialLoadingState extends CredentialState {
  @override
  List<Object> get props => [];
}

class CredentialSuccessState extends CredentialState {
  String? uid;
  CredentialSuccessState(this.uid);
  @override
  List<Object> get props => [uid!];
}

class CredentialFailureState extends CredentialState {
  @override
  List<Object> get props => [];
}
