import 'package:json_annotation/json_annotation.dart';

part 'userRole.g.dart';

@JsonSerializable()
class UserRole{
  int? roleId;

  UserRole(this.roleId);

  factory UserRole.fromJson(Map<String, dynamic> json) => _$UserRoleFromJson(json);

  /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$UserRoleToJson(this);
}