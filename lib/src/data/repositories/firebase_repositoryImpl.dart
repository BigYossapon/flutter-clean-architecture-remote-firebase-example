import 'dart:io';

import 'package:struccleancrudexam/src/domain/entities/user_entity.dart';

import '../../domain/repositories/firebase_repository.dart';
import '../datasources/remote/firebase_remote_datasource.dart';

class FirebaseRepositoryImpl extends FirebaseRepository {
  final FirebaseRemoteDataSource firebaseRemoteDataSource;

  FirebaseRepositoryImpl({required this.firebaseRemoteDataSource});
  @override
  Future<void> createUser(UserEntity user) async {
    // TODO: implement createUser
    firebaseRemoteDataSource.createUser(user);
  }

  @override
  Future<void> deleteUser(String uid) async {
    // TODO: implement deleteUser
    firebaseRemoteDataSource.deleteUser(uid);
  }

  @override
  Future<String> getCurrentUid() async {
    // TODO: implement getCurrentUid
    return firebaseRemoteDataSource.getCurrentUid();
  }

  @override
  Future<UserEntity> getSingleOtherUser(String otheruid) =>
      // TODO: implement getSingleOtherUser
      firebaseRemoteDataSource.getSingleOtherUser(otheruid);

  @override
  Stream<UserEntity> getSingleUser(String uid) =>
      // TODO: implement getSingleUser
      firebaseRemoteDataSource.getSingleUser(uid);

  @override
  Stream<List<UserEntity>> getUsers() =>
      // TODO: implement getUsers
      firebaseRemoteDataSource.getUsers();

  @override
  Future<bool> isSignIn() {
    // TODO: implement isSignIn
    return firebaseRemoteDataSource.isSignIn();
  }

  @override
  Future<void> signInUser(UserEntity user) async {
    // TODO: implement signInUser
    firebaseRemoteDataSource.signInUser(user);
  }

  @override
  Future<void> signOut() async {
    // TODO: implement signOut
    firebaseRemoteDataSource.signOut();
  }

  @override
  Future<String?> signUpUser(UserEntity user) async {
    // TODO: implement signUpUser
    return firebaseRemoteDataSource.signUpUser(user);
  }

  @override
  Future<void> updateUser(UserEntity user) async {
    // TODO: implement updateUser
    firebaseRemoteDataSource.updateUser(user);
  }

  @override
  Future<String> uploadImageToStorage(File? file, String childName) async {
    // TODO: implement uploadImageToStorage
    return firebaseRemoteDataSource.uploadImageToStorage(file, childName);
  }
}
