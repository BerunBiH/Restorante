import 'package:erestorante_mobile/models/role.dart';
import 'package:json_annotation/json_annotation.dart';

part 'ratingStaffInsert.g.dart';

@JsonSerializable(explicitToJson: true)
class RatingStaffInsert{
  int? customerId;
  int? userId;
  int? ratingNumber;

  RatingStaffInsert(this.customerId, this.userId, this.ratingNumber);

  factory RatingStaffInsert.fromJson(Map<String, dynamic> json) => _$RatingStaffInsertFromJson(json);

  /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$RatingStaffInsertToJson(this);
}