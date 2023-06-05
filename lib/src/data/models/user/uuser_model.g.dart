// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'uuser_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UuserModel _$UuserModelFromJson(Map<String, dynamic> json) => UuserModel(
      uid: json['uid'] as String?,
      username: json['username'] as String?,
      address: json['address'] as String?,
      email: json['email'] as String?,
      country: json['country'] as String?,
      password: json['password'] as String?,
      avatar: json['avatar'] as String?,
    );

Map<String, dynamic> _$UuserModelToJson(UuserModel instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'username': instance.username,
      'address': instance.address,
      'email': instance.email,
      'country': instance.country,
      'password': instance.password,
      'avatar': instance.avatar,
    };
