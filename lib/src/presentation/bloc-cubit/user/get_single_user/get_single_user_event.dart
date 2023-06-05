part of 'get_single_user_bloc.dart';

abstract class GetSingleUserEvent extends Equatable {
  const GetSingleUserEvent();

  @override
  List<Object> get props => [];
}

class GetSingleUser_Event extends GetSingleUserEvent {
  String uid;
  GetSingleUser_Event({required this.uid});
  @override
  List<Object> get props => [uid];
}
