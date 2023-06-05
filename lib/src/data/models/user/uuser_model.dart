import '../../../domain/entities/user_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'uuser_model.g.dart';

@JsonSerializable()
class UuserModel extends UserEntity {
  @JsonKey(name: 'uid')
  final String? uid;
  @JsonKey(name: 'username')
  final String? username;
  @JsonKey(name: 'address')
  final String? address;
  @JsonKey(name: 'email')
  final String? email;
  @JsonKey(name: 'country')
  final String? country;
  @JsonKey(name: 'password')
  final String? password;
  @JsonKey(name: 'avatar')
  final String? avatar;

  UuserModel(
      {this.uid,
      this.username,
      this.address,
      this.email,
      this.country,
      this.password,
      this.avatar});

  factory UuserModel.fromJson(Map<String, dynamic> json) =>
      _$UuserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UuserModelToJson(this);
}
