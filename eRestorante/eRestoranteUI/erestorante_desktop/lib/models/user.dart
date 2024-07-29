import 'dart:typed_data';
import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User{
  int? userId;
  String? userName;
  String? userSurname;
  String? userEmail;
  String? userPhone;
  int? userStatus;
  String? userImage;

  User(this.userId, this.userName, this.userSurname, this.userEmail, this.userPhone, this.userStatus, this.userImage);
  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$UserToJson(this);
}