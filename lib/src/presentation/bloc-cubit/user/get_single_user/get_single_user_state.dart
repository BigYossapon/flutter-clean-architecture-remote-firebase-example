part of 'get_single_user_bloc.dart';

abstract class GetSingleUserState extends Equatable {
  const GetSingleUserState();

  @override
  List<Object> get props => [];
}

class GetSingleUserInitialState extends GetSingleUserState {
  @override
  List<Object> get props => [];
}

class GetSingleUserLoadingState extends GetSingleUserState {
  @override
  List<Object> get props => [];
}

class GetSingleUserLoadedState extends GetSingleUserState {
  final UserEntity user;

  GetSingleUserLoadedState({required this.user});
  @override
  List<Object> get props => [user];
}

class GetSingleUserFailureState extends GetSingleUserState {
  @override
  List<Object> get props => [];
}
