// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'userRoleUpdate.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserRoleUpdate _$UserRoleUpdateFromJson(Map<String, dynamic> json) =>
    UserRoleUpdate(
      (json['roleId'] as num?)?.toInt(),
      json['dateChange'] as String?,
    );

Map<String, dynamic> _$UserRoleUpdateToJson(UserRoleUpdate instance) =>
    <String, dynamic>{
      'roleId': instance.roleId,
      'dateChange': instance.dateChange,
    };
