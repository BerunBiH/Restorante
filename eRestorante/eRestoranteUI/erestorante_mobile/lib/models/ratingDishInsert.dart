import 'package:erestorante_mobile/models/role.dart';
import 'package:json_annotation/json_annotation.dart';

part 'ratingDishInsert.g.dart';

@JsonSerializable(explicitToJson: true)
class RatingDishInsert{
  int? customerId;
  int? dishId;
  int? ratingNumber;

  RatingDishInsert(this.customerId, this.dishId, this.ratingNumber);

  factory RatingDishInsert.fromJson(Map<String, dynamic> json) => _$RatingDishInsertFromJson(json);

  /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$RatingDishInsertToJson(this);
}