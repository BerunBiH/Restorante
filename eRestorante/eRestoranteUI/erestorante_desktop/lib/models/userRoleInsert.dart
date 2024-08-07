import 'package:erestorante_desktop/models/userRole.dart';
import 'package:json_annotation/json_annotation.dart';

part 'userRoleInsert.g.dart';

@JsonSerializable(explicitToJson: true)
class UserRoleInsert{
  int? userId;
  int? roleId;
  String? dateChange;

  UserRoleInsert(this.userId, this.roleId, this.dateChange);
  factory UserRoleInsert.fromJson(Map<String, dynamic> json) => _$UserRoleInsertFromJson(json);

  /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$UserRoleInsertToJson(this);
}