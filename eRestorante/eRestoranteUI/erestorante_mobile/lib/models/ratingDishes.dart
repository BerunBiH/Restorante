import 'package:erestorante_mobile/models/role.dart';
import 'package:json_annotation/json_annotation.dart';

part 'ratingDishes.g.dart';

@JsonSerializable(explicitToJson: true)
class RatingDishes{
  int? ratingId;
  int? dishId;
  int? ratingNumber;
  String? ratingDate;

  RatingDishes(this.ratingId, this.dishId, this.ratingNumber, this.ratingDate);

  factory RatingDishes.fromJson(Map<String, dynamic> json) => _$RatingDishesFromJson(json);

  /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$RatingDishesToJson(this);
}