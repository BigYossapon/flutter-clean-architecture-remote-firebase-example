import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:struccleancrudexam/src/domain/entities/user_entity.dart';
import 'package:struccleancrudexam/src/utils/shared/secure_storage/user_secure_storage.dart';

import '../../../utils/shared/config/const.dart';
import '../../models/user/user_model.dart';
import '../../models/user/uuser_model.dart';
import 'firebase_remote_datasource.dart';

class FirebaseRemoteDataSourceImpl extends FirebaseRemoteDataSource {
  final FirebaseAuth firebaseAuth;
  final FirebaseStorage firebaseStorage;
  final FirebaseFirestore firebaseFirestore;

  FirebaseRemoteDataSourceImpl(
      {required this.firebaseAuth,
      required this.firebaseStorage,
      required this.firebaseFirestore});

  static final _fireStoreUserCollection =
      FirebaseFirestore.instance.collection('users');

  @override
  Future<void> createUser(UserEntity user) async {
    // TODO: implement createUser
    final userCollection = firebaseFirestore.collection(FirebaseConst.users);

    userCollection.doc(user.uid).get().then((userDoc) {
      final newUser = UserModel(
        uid: user.uid,
        email: user.email,
        avatar: user.avatar,
        username: user.username,
        address: user.address,
        country: user.country,
        password: user.password,
      ).toJson();

      if (!userDoc.exists) {
        userCollection.doc(user.uid).set(newUser);
      }
      // else {
      //   userCollection.doc(user.uid).update(newUser);
      // }
    }).catchError((error) {
      Fluttertoast.showToast(msg: "Some error occur");
      //toast("Some error occur");
    });
  }

  @override
  Future<void> deleteUser(String uid) async {
    // TODO: implement deleteUser
    final userCollection = firebaseFirestore.collection(FirebaseConst.users);
    try {
      firebaseAuth.currentUser!.delete();
      userCollection.doc(uid).delete().then((value) {
        final userCollection =
            firebaseFirestore.collection(FirebaseConst.users).doc(uid);
      });
    } catch (e) {
      Fluttertoast.showToast(msg: "has some error");
    }
  }

  @override
  Future<String> getCurrentUid() async => firebaseAuth.currentUser!.uid;
  // TODO: implement getCurrentUid

  @override
  Future<UserEntity> getSingleOtherUser(String otherUid) async {
    UuserModel userPersonalInfo = UuserModel();
    await _fireStoreUserCollection
        .where('uid', isEqualTo: otherUid)
        .get()
        .then((snapshot) {
      if (snapshot.docs.isNotEmpty) {
        QueryDocumentSnapshot<Map<String, dynamic>> snap = snapshot.docs[0];
        userPersonalInfo = UuserModel.fromJson(snap.data());
      }
    });
    return userPersonalInfo;
  }

  @override
  Stream<UserEntity> getSingleUser(String uid) {
    // TODO: implement getSingleUser
    // final userCollection = firebaseFirestore
    //     .collection(FirebaseConst.users)
    //     .where("uid", isEqualTo: uid)
    //     .limit(1);
    // return userCollection.snapshots().map((querySnapshot) =>
    //     querySnapshot.docs.map((e) => UserModel.fromSnapshot(e)).toList());
    if (uid.isNotEmpty) {
      Stream<DocumentSnapshot<Map<String, dynamic>>> snapshotsInfo =
          _fireStoreUserCollection.doc(uid).snapshots();
      return snapshotsInfo.map((snapshot) {
        UuserModel info = UuserModel.fromJson(snapshot.data()!);
        return info;
      });
    } else {
      return Stream.error("No personal id");
    }
  }

  @override
  Stream<List<UserEntity>> getUsers() {
    // TODO: implement getUsers
    // final userCollection = firebaseFirestore.collection(FirebaseConst.users);
    // return userCollection.snapshots().map((querySnapshot) =>
    //     querySnapshot.docs.map((e) => UserModel.fromSnapshot(e)).toList());

    Stream<QuerySnapshot<Map<String, dynamic>>> snapshots =
        _fireStoreUserCollection.snapshots();
    return snapshots.map((snapshot) {
      List<UserEntity> usersInfo = [];
      for (final doc in snapshot.docs) {
        String uid = "";
        UserSecureStorage.getUid().then((value) => uid = value!);
        UserModel userInfo =
            UserModel.fromSnapshot(doc.data() as DocumentSnapshot<Object?>);
        if (userInfo.uid != uid) usersInfo.add(userInfo);
      }
      return usersInfo;
    });
  }

  @override
  Future<bool> isSignIn() async => firebaseAuth.currentUser?.uid != null;

  @override
  Future<void> signInUser(UserEntity user) async {
    // TODO: implement signInUser
    try {
      if (user.email!.isNotEmpty || user.password!.isNotEmpty) {
        await firebaseAuth.signInWithEmailAndPassword(
            email: user.email!, password: user.password!);
      } else {
        print("fields cannot be empty");
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == "user-not-found") {
        Fluttertoast.showToast(msg: "user not found");
      } else if (e.code == "wrong-password") {
        Fluttertoast.showToast(msg: "Invalid email or password");
      }
    }
  }

  @override
  Future<void> signOut() async {
    // TODO: implement signOut
    await firebaseAuth.signOut();
  }

  @override
  Future<String?> signUpUser(UserEntity user) async {
    // TODO: implement signUpUser
    String uid = "";
    try {
      await firebaseAuth
          .createUserWithEmailAndPassword(
              email: user.email!, password: user.password!)
          .then((currentUser) async {
        uid = currentUser.user!.uid;
        if (currentUser.user?.uid != null) {
          Fluttertoast.showToast(msg: "success");
        }
      });
      return uid;
    } on FirebaseAuthException catch (e) {
      if (e.code == "email-already-in-use") {
        Fluttertoast.showToast(msg: "email is already taken");
      } else {
        Fluttertoast.showToast(msg: "something went wrong");
      }
    }
  }

  @override
  Future<void> updateUser(UserEntity user) async {
    // TODO: implement updateUser
    final userCollection = firebaseFirestore.collection(FirebaseConst.users);
    Map<String, dynamic> userInformation = Map();

    if (user.username != "" && user.username != null)
      userInformation['username'] = user.username;

    if (user.password != "" && user.password != null)
      userInformation['password'] = user.password;

    if (user.avatar != "" && user.avatar != null)
      userInformation['avatar'] = user.avatar;

    if (user.country != "" && user.country != null)
      userInformation['country'] = user.country;

    if (user.email != "" && user.email != null)
      userInformation['email'] = user.email;

    if (user.address != "" && user.address != null)
      userInformation['address'] = user.address;

    userCollection.doc(user.uid).update(userInformation);
  }

  @override
  Future<String> uploadImageToStorage(File? file, String childName) async {
    // TODO: implement uploadImageToStorage
    Reference ref = firebaseStorage
        .ref()
        .child(childName)
        .child(firebaseAuth.currentUser!.uid);

    //
    String id = firebaseAuth.currentUser!.uid;
    ref = ref.child(id);

    final uploadTask = ref.putFile(file!);

    final imageUrl =
        (await uploadTask.whenComplete(() {})).ref.getDownloadURL();

    return await imageUrl;
  }
}
