part of 'get_single_other_user_bloc.dart';

abstract class GetSingleOtherUserEvent extends Equatable {
  const GetSingleOtherUserEvent();

  @override
  List<Object> get props => [];
}

class GetSingleOtherUser_Event extends GetSingleOtherUserEvent {
  String otherUid;
  GetSingleOtherUser_Event({required this.otherUid});
  @override
  List<Object> get props => [otherUid];
}
