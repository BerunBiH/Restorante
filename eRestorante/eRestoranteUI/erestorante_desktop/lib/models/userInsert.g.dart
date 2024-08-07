// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'userInsert.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserInsert _$UserInsertFromJson(Map<String, dynamic> json) => UserInsert(
      json['userName'] as String?,
      json['userSurname'] as String?,
      json['userEmail'] as String?,
      json['userPhone'] as String?,
      json['userPassword'] as String?,
      json['userPasswordRepeat'] as String?,
      (json['userStatus'] as num?)?.toInt(),
      json['userImage'] as String?,
    );

Map<String, dynamic> _$UserInsertToJson(UserInsert instance) =>
    <String, dynamic>{
      'userName': instance.userName,
      'userSurname': instance.userSurname,
      'userEmail': instance.userEmail,
      'userPhone': instance.userPhone,
      'userPassword': instance.userPassword,
      'userPasswordRepeat': instance.userPasswordRepeat,
      'userStatus': instance.userStatus,
      'userImage': instance.userImage,
    };
