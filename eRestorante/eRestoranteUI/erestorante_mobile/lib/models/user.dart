import 'package:erestorante_mobile/models/commentStaffs.dart';
import 'package:erestorante_mobile/models/ratingStaffs.dart';
import 'package:erestorante_mobile/models/userRole.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable(explicitToJson: true)
class User{
  int? userId;
  String? userName;
  String? userSurname;
  String? userEmail;
  String? userPhone;
  int? userStatus;
  String? userImage;
  List<UserRole>? userRoles;
  List<CommentStaffs>? commentStaffs;
  List<RatingStaffs>? ratingStaffs;

  User(this.userId, this.userName, this.userSurname, this.userEmail, this.userPhone, this.userStatus, this.userImage, this.userRoles);
  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$UserToJson(this);
}