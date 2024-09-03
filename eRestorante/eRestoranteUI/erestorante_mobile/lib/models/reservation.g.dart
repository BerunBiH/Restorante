// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reservation.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Reservation _$ReservationFromJson(Map<String, dynamic> json) => Reservation(
      (json['reservationId'] as num?)?.toInt(),
      json['reservationDate'] as String?,
      json['reservationTime'] as String?,
      (json['numberOfGuests'] as num?)?.toInt(),
      (json['numberOfHours'] as num?)?.toInt(),
      (json['reservationStatus'] as num?)?.toInt(),
      (json['customerId'] as num?)?.toInt(),
      json['reservationReason'] as String?,
      (json['numberOfMinors'] as num?)?.toInt(),
      json['contactPhone'] as String?,
      json['specialWishes'] as String?,
      json['customer'] == null
          ? null
          : Customer.fromJson(json['customer'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ReservationToJson(Reservation instance) =>
    <String, dynamic>{
      'reservationId': instance.reservationId,
      'reservationDate': instance.reservationDate,
      'reservationTime': instance.reservationTime,
      'numberOfGuests': instance.numberOfGuests,
      'numberOfHours': instance.numberOfHours,
      'reservationStatus': instance.reservationStatus,
      'customerId': instance.customerId,
      'reservationReason': instance.reservationReason,
      'numberOfMinors': instance.numberOfMinors,
      'contactPhone': instance.contactPhone,
      'specialWishes': instance.specialWishes,
      'customer': instance.customer?.toJson(),
    };
