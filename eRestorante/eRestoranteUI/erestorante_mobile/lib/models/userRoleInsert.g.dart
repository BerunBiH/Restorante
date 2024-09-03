// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'userRoleInsert.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserRoleInsert _$UserRoleInsertFromJson(Map<String, dynamic> json) =>
    UserRoleInsert(
      (json['userId'] as num?)?.toInt(),
      (json['roleId'] as num?)?.toInt(),
      json['dateChange'] as String?,
    );

Map<String, dynamic> _$UserRoleInsertToJson(UserRoleInsert instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'roleId': instance.roleId,
      'dateChange': instance.dateChange,
    };
