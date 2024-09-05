// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ratingStaffInsert.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RatingStaffInsert _$RatingStaffInsertFromJson(Map<String, dynamic> json) =>
    RatingStaffInsert(
      (json['customerId'] as num?)?.toInt(),
      (json['userId'] as num?)?.toInt(),
      (json['ratingNumber'] as num?)?.toInt(),
    );

Map<String, dynamic> _$RatingStaffInsertToJson(RatingStaffInsert instance) =>
    <String, dynamic>{
      'customerId': instance.customerId,
      'userId': instance.userId,
      'ratingNumber': instance.ratingNumber,
    };
