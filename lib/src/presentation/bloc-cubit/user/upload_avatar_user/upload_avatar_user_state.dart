part of 'upload_avatar_user_bloc.dart';

abstract class UploadAvatarUserState extends Equatable {
  const UploadAvatarUserState();

  @override
  List<Object> get props => [];
}

class UploadAvatarUserInitialState extends UploadAvatarUserState {
  @override
  List<Object> get props => [];
}

class UploadingAvatarUserState extends UploadAvatarUserState {
  @override
  List<Object> get props => [];
}

class UploadedAvatarUserState extends UploadAvatarUserState {
  String avatar;
  UploadedAvatarUserState({required this.avatar});
  @override
  List<Object> get props => [];
}

class UploadErrorAvatarUserState extends UploadAvatarUserState {
  @override
  List<Object> get props => [];
}
