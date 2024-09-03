// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'customerInsert.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CustomerInsert _$CustomerInsertFromJson(Map<String, dynamic> json) =>
    CustomerInsert(
      json['customerName'] as String?,
      json['customerSurname'] as String?,
      json['customerEmail'] as String?,
      json['customerPhone'] as String?,
      json['customerPassword'] as String?,
      json['customerPasswordRepeat'] as String?,
      json['customerImage'] as String?,
    );

Map<String, dynamic> _$CustomerInsertToJson(CustomerInsert instance) =>
    <String, dynamic>{
      'customerName': instance.customerName,
      'customerSurname': instance.customerSurname,
      'customerEmail': instance.customerEmail,
      'customerPhone': instance.customerPhone,
      'customerPassword': instance.customerPassword,
      'customerPasswordRepeat': instance.customerPasswordRepeat,
      'customerImage': instance.customerImage,
    };
