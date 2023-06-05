part of 'get_single_other_user_bloc.dart';

abstract class GetSingleOtherUserState extends Equatable {
  const GetSingleOtherUserState();

  @override
  List<Object> get props => [];
}

class GetSingleOtherUserInitialState extends GetSingleOtherUserState {
  @override
  List<Object> get props => [];
}

class GetSingleOtherUserLoadingState extends GetSingleOtherUserState {
  @override
  List<Object> get props => [];
}

class GetSingleOtherUserLoadedState extends GetSingleOtherUserState {
  final UserEntity otherUser;

  GetSingleOtherUserLoadedState({required this.otherUser});
  @override
  List<Object> get props => [otherUser];
}

class GetSingleOtherUserFailureState extends GetSingleOtherUserState {
  @override
  List<Object> get props => [];
}
