import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:struccleancrudexam/src/domain/entities/user_entity.dart';
import 'package:struccleancrudexam/src/domain/usecases/firebase_usecases/storage/upload_image_to_storage_usecase.dart';
import 'package:struccleancrudexam/src/domain/usecases/firebase_usecases/user/get_current_uid_usecase.dart';
import 'package:struccleancrudexam/src/domain/usecases/firebase_usecases/user/update_user_usecase.dart';
import 'package:struccleancrudexam/src/utils/shared/share_preferences/user_share_preference.dart';

part 'upload_avatar_user_event.dart';
part 'upload_avatar_user_state.dart';

class UploadAvatarUserBloc
    extends Bloc<UploadAvatarUserEvent, UploadAvatarUserState> {
  final UploadImageToStorageUseCase uploadImageToStorageUseCase;
  final UpdateUserUseCase updateUserUseCase;
  final GetCurrentUidUseCase getCurrentUidUseCase;
  UploadAvatarUserBloc(
      {required this.uploadImageToStorageUseCase,
      required this.updateUserUseCase,
      required this.getCurrentUidUseCase})
      : super(UploadAvatarUserInitialState()) {
    on<UploadAvatarUser_Event>((event, emit) async {
      // TODO: implement event handler
      emit(UploadingAvatarUserState());
      try {
        final uid = await getCurrentUidUseCase.call();
        String childName = "avatar-$uid";
        final avatarUrl =
            await uploadImageToStorageUseCase.call(event.avatar, childName);

        final user = UserEntity(uid: uid, avatar: avatarUrl);
        await updateUserUseCase.call(user);
        emit(UploadedAvatarUserState(avatar: avatarUrl));
      } on SocketException catch (_) {
        emit(UploadErrorAvatarUserState());
      } catch (_) {
        emit(UploadErrorAvatarUserState());
      }
    });
  }
}
