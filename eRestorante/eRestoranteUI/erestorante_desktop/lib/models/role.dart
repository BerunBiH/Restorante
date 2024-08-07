import 'package:json_annotation/json_annotation.dart';

part 'role.g.dart';

@JsonSerializable()
class Role{
  int? rolesId;
  String? roleName;
  String? roleDescription;

  Role(this.rolesId, this.roleName, this.roleDescription);
  factory Role.fromJson(Map<String, dynamic> json) => _$RoleFromJson(json);

  /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$RoleToJson(this);
}