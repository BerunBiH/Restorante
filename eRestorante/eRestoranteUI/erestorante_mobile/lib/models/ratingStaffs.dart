import 'package:erestorante_mobile/models/role.dart';
import 'package:json_annotation/json_annotation.dart';

part 'ratingStaffs.g.dart';

@JsonSerializable(explicitToJson: true)
class RatingStaffs{
  int? ratingStaffId;
  int? ratingNumber;
  String? ratingDate;

  RatingStaffs(this.ratingStaffId, this.ratingNumber, this.ratingDate);

  factory RatingStaffs.fromJson(Map<String, dynamic> json) => _$RatingStaffsFromJson(json);

  /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$RatingStaffsToJson(this);
}