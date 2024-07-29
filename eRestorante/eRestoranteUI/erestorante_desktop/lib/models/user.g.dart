// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      (json['userId'] as num?)?.toInt(),
      json['userName'] as String?,
      json['userSurname'] as String?,
      json['userEmail'] as String?,
      json['userPhone'] as String?,
      (json['userStatus'] as num?)?.toInt(),
      json['userImage'] as String?,
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'userId': instance.userId,
      'userName': instance.userName,
      'userSurname': instance.userSurname,
      'userEmail': instance.userEmail,
      'userPhone': instance.userPhone,
      'userStatus': instance.userStatus,
      'userImage': instance.userImage,
    };
