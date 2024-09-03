import 'package:erestorante_mobile/models/customer.dart';
import 'package:json_annotation/json_annotation.dart';

part 'reservation.g.dart';

@JsonSerializable(explicitToJson: true)
class Reservation{
  int? reservationId;
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
  Customer? customer;

  Reservation(this.reservationId, this.reservationDate, this.reservationTime, this.numberOfGuests, this.numberOfHours, this.reservationStatus, this.customerId, this.reservationReason, this.numberOfMinors, this.contactPhone, this.specialWishes, this.customer);
  factory Reservation.fromJson(Map<String, dynamic> json) => _$ReservationFromJson(json);

  /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$ReservationToJson(this);
}