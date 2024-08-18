// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reservationUpdate.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReservationUpdate _$ReservationUpdateFromJson(Map<String, dynamic> json) =>
    ReservationUpdate(
      json['reservationDate'] as String?,
      json['reservationTime'] as String?,
      (json['numberOfGuests'] as num?)?.toInt(),
      (json['numberOfHours'] as num?)?.toInt(),
      (json['reservationStatus'] as num?)?.toInt(),
      json['reservationReason'] as String?,
      (json['numberOfMinors'] as num?)?.toInt(),
      json['contactPhone'] as String?,
      json['specialWishes'] as String?,
    );

Map<String, dynamic> _$ReservationUpdateToJson(ReservationUpdate instance) =>
    <String, dynamic>{
      'reservationDate': instance.reservationDate,
      'reservationTime': instance.reservationTime,
      'numberOfGuests': instance.numberOfGuests,
      'numberOfHours': instance.numberOfHours,
      'reservationStatus': instance.reservationStatus,
      'reservationReason': instance.reservationReason,
      'numberOfMinors': instance.numberOfMinors,
      'contactPhone': instance.contactPhone,
      'specialWishes': instance.specialWishes,
    };
