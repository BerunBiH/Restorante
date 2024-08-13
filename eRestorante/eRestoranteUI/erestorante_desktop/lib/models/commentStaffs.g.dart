// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'commentStaffs.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CommentStaffs _$CommentStaffsFromJson(Map<String, dynamic> json) =>
    CommentStaffs(
      (json['commentStaffId'] as num?)?.toInt(),
      json['commentDate'] as String?,
      json['commentText'] as String?,
    );

Map<String, dynamic> _$CommentStaffsToJson(CommentStaffs instance) =>
    <String, dynamic>{
      'commentStaffId': instance.commentStaffId,
      'commentDate': instance.commentDate,
      'commentText': instance.commentText,
    };
