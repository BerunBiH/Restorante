import 'package:erestorante_desktop/models/role.dart';
import 'package:json_annotation/json_annotation.dart';

part 'userRole.g.dart';

@JsonSerializable(explicitToJson: true)
class UserRole{
  int? userRolesId;
  int? roleId;
  Role? role;

  UserRole(this.userRolesId, this.roleId, this.role);

  factory UserRole.fromJson(Map<String, dynamic> json) => _$UserRoleFromJson(json);

  /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$UserRoleToJson(this);
}