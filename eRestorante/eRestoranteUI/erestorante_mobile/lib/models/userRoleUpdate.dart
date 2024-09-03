import 'package:erestorante_mobile/models/userRole.dart';
import 'package:intl/intl.dart';
import 'package:json_annotation/json_annotation.dart';

part 'userRoleUpdate.g.dart';

@JsonSerializable(explicitToJson: true)
class UserRoleUpdate{
  int? roleId;
  String? dateChange;

  UserRoleUpdate(this.roleId, this.dateChange);
  factory UserRoleUpdate.fromJson(Map<String, dynamic> json) => _$UserRoleUpdateFromJson(json);

  /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$UserRoleUpdateToJson(this);
}