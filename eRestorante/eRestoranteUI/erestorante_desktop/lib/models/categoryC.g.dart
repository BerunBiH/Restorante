// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'categoryC.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CategoryC _$CategoryCFromJson(Map<String, dynamic> json) => CategoryC(
      (json['categoryId'] as num?)?.toInt(),
      json['categoryName'] as String?,
    );

Map<String, dynamic> _$CategoryCToJson(CategoryC instance) => <String, dynamic>{
      'categoryId': instance.categoryId,
      'categoryName': instance.categoryName,
    };
