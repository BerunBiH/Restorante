import 'package:json_annotation/json_annotation.dart';

part 'reservationInsert.g.dart';

@JsonSerializable(explicitToJson: true)
class ReservationInsert{
  String? reservationDate;
  String? reservationTime;
  int? numberOfGuests;
  int? numberOfHours;
  int? reservationStatus;
  int? customerId;
  String? reservationReason;
  int? numberOfMinors;
  String? contactPhone;
  String? specialWishes;

  ReservationInsert(this.reservationDate, this.reservationTime, this.numberOfGuests, this.numberOfHours, this.reservationStatus,this.customerId, this.reservationReason, this.numberOfMinors, this.contactPhone, this.specialWishes);
  factory ReservationInsert.fromJson(Map<String, dynamic> json) => _$ReservationInsertFromJson(json);

  /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$ReservationInsertToJson(this);
}