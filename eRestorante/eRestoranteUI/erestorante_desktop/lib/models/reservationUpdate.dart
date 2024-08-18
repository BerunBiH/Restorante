import 'package:json_annotation/json_annotation.dart';

part 'reservationUpdate.g.dart';

@JsonSerializable(explicitToJson: true)
class ReservationUpdate{
  String? reservationDate;
  String? reservationTime;
  int? numberOfGuests;
  int? numberOfHours;
  int? reservationStatus;
  String? reservationReason;
  int? numberOfMinors;
  String? contactPhone;
  String? specialWishes;

  ReservationUpdate(this.reservationDate, this.reservationTime, this.numberOfGuests, this.numberOfHours, this.reservationStatus, this.reservationReason, this.numberOfMinors, this.contactPhone, this.specialWishes);
  factory ReservationUpdate.fromJson(Map<String, dynamic> json) => _$ReservationUpdateFromJson(json);

  /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$ReservationUpdateToJson(this);
}