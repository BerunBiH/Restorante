import 'package:erestorante_desktop/models/userRole.dart';
import 'package:json_annotation/json_annotation.dart';

part 'userInsert.g.dart';

@JsonSerializable(explicitToJson: true)
class UserInsert{
  String? userName;
  String? userSurname;
  String? userEmail;
  String? userPhone;
  String? userPassword;
  String? userPasswordRepeat;
  int? userStatus;
  String? userImage;

  UserInsert(this.userName, this.userSurname, this.userEmail, this.userPhone, this.userPassword, this.userPasswordRepeat, this.userStatus, this.userImage);
  factory UserInsert.fromJson(Map<String, dynamic> json) => _$UserInsertFromJson(json);

  /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$UserInsertToJson(this);
}