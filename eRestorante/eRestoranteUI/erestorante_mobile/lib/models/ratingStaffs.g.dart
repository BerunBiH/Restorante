// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ratingStaffs.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RatingStaffs _$RatingStaffsFromJson(Map<String, dynamic> json) => RatingStaffs(
      (json['ratingStaffId'] as num?)?.toInt(),
      (json['userId'] as num?)?.toInt(),
      (json['ratingNumber'] as num?)?.toInt(),
      json['ratingDate'] as String?,
    );

Map<String, dynamic> _$RatingStaffsToJson(RatingStaffs instance) =>
    <String, dynamic>{
      'ratingStaffId': instance.ratingStaffId,
      'userId': instance.userId,
      'ratingNumber': instance.ratingNumber,
      'ratingDate': instance.ratingDate,
    };
