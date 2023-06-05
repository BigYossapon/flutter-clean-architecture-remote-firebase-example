part of 'upload_avatar_user_bloc.dart';

abstract class UploadAvatarUserEvent extends Equatable {
  const UploadAvatarUserEvent();

  @override
  List<Object> get props => [];
}

class UploadAvatarUser_Event extends UploadAvatarUserEvent {
  File avatar;
  UploadAvatarUser_Event({required this.avatar});
  @override
  List<Object> get props => [];
}
