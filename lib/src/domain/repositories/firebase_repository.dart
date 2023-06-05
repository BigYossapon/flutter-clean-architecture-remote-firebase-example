import 'dart:io';

import '../entities/user_entity.dart';

abstract class FirebaseRepository {
  // Credential Features
  Future<void> signInUser(UserEntity user);
  Future<String?> signUpUser(UserEntity user);
  Future<bool> isSignIn();
  Future<void> signOut();

  // User Features
  Stream<List<UserEntity>> getUsers();
  Stream<UserEntity> getSingleUser(String uid);
  Stream<List<UserEntity>> getSingleOtherUser(String otheruid);

  Future<String> getCurrentUid();
  Future<void> createUser(UserEntity user);
  Future<void> updateUser(UserEntity user);
  Future<void> deleteUser(String uid);

  // Cloud Storage Feature
  Future<String> uploadImageToStorage(File? file, String childName);
}
