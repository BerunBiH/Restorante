// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'commentDishInsert.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CommentDishInsert _$CommentDishInsertFromJson(Map<String, dynamic> json) =>
    CommentDishInsert(
      (json['dishId'] as num?)?.toInt(),
      (json['CustomerId'] as num?)?.toInt(),
      json['commentText'] as String?,
    );

Map<String, dynamic> _$CommentDishInsertToJson(CommentDishInsert instance) =>
    <String, dynamic>{
      'dishId': instance.dishId,
      'CustomerId': instance.CustomerId,
      'commentText': instance.commentText,
    };
