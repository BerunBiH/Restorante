// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'commentStaffInsert.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CommentStaffInsert _$CommentStaffInsertFromJson(Map<String, dynamic> json) =>
    CommentStaffInsert(
      (json['customerId'] as num?)?.toInt(),
      (json['userId'] as num?)?.toInt(),
      json['commentText'] as String?,
    );

Map<String, dynamic> _$CommentStaffInsertToJson(CommentStaffInsert instance) =>
    <String, dynamic>{
      'customerId': instance.customerId,
      'userId': instance.userId,
      'commentText': instance.commentText,
    };
