import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String? uid;
  final String? username;
  final String? address;
  final String? email;
  final String? country;
  final String? password;
  final String? avatar;

  UserEntity(
      {this.uid,
      this.username,
      this.address,
      this.email,
      this.country,
      this.password,
      this.avatar});

  @override
  // TODO: implement props
  List<Object?> get props =>
      [uid, username, address, email, country, password, avatar];
}
