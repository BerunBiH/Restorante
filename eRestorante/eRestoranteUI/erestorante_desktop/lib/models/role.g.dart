// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'role.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Role _$RoleFromJson(Map<String, dynamic> json) => Role(
      (json['rolesId'] as num?)?.toInt(),
      json['roleName'] as String?,
      json['roleDescription'] as String?,
    );

Map<String, dynamic> _$RoleToJson(Role instance) => <String, dynamic>{
      'rolesId': instance.rolesId,
      'roleName': instance.roleName,
      'roleDescription': instance.roleDescription,
    };
