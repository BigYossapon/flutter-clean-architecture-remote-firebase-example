import 'dart:io';

import '../../../repositories/firebase_repository.dart';

class UploadImageToStorageUseCase {
  final FirebaseRepository firebaseRepository;
  UploadImageToStorageUseCase({required this.firebaseRepository});

  Future<String> call(File? file, String childName) async {
    return firebaseRepository.uploadImageToStorage(file, childName);
  }
}
