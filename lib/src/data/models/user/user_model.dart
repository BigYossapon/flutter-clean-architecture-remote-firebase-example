import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:struccleancrudexam/src/domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  final String? uid;
  final String? username;
  final String? address;
  final String? email;
  final String? country;
  final String? password;
  final String? avatar;

  UserModel(
      {this.uid,
      this.username,
      this.address,
      this.email,
      this.country,
      this.password,
      this.avatar})
      : super(
            uid: uid,
            username: username,
            address: address,
            email: email,
            country: country,
            password: password,
            avatar: avatar);

  factory UserModel.fromSnapshot(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return UserModel(
      email: snapshot['email'],
      username: snapshot['username'],
      address: snapshot['address'],
      country: snapshot['country'],
      password: snapshot['password'],
      uid: snapshot['uid'],
      avatar: snapshot['avatar'],
    );
  }

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "email": email,
        "username": username,
        "address": address,
        "country": country,
        "password": password,
        "avatar": avatar
      };
}
