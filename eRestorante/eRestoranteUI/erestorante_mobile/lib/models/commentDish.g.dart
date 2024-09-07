// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'commentDish.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CommentDish _$CommentDishFromJson(Map<String, dynamic> json) => CommentDish(
      (json['commentDishId'] as num?)?.toInt(),
      (json['dishId'] as num?)?.toInt(),
      json['commentDate'] as String?,
      json['commentText'] as String?,
    );

Map<String, dynamic> _$CommentDishToJson(CommentDish instance) =>
    <String, dynamic>{
      'commentDishId': instance.commentDishId,
      'dishId': instance.dishId,
      'commentDate': instance.commentDate,
      'commentText': instance.commentText,
    };
