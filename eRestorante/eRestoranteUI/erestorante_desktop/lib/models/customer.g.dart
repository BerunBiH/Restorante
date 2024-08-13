// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'customer.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Customer _$CustomerFromJson(Map<String, dynamic> json) => Customer(
      (json['customerId'] as num?)?.toInt(),
      json['customerName'] as String?,
      json['customerSurname'] as String?,
      json['customerEmail'] as String?,
      json['customerPhone'] as String?,
      json['customerDateRegister'] as String?,
      json['customerImage'] as String?,
    );

Map<String, dynamic> _$CustomerToJson(Customer instance) => <String, dynamic>{
      'customerId': instance.customerId,
      'customerName': instance.customerName,
      'customerSurname': instance.customerSurname,
      'customerEmail': instance.customerEmail,
      'customerPhone': instance.customerPhone,
      'customerDateRegister': instance.customerDateRegister,
      'customerImage': instance.customerImage,
    };
