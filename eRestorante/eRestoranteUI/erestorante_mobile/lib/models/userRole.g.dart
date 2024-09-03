// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'userRole.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserRole _$UserRoleFromJson(Map<String, dynamic> json) => UserRole(
      (json['userRolesId'] as num?)?.toInt(),
      (json['roleId'] as num?)?.toInt(),
      json['role'] == null
          ? null
          : Role.fromJson(json['role'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UserRoleToJson(UserRole instance) => <String, dynamic>{
      'userRolesId': instance.userRolesId,
      'roleId': instance.roleId,
      'role': instance.role?.toJson(),
    };
