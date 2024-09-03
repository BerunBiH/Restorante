
import 'package:json_annotation/json_annotation.dart';

part 'drinkUpdate.g.dart';

@JsonSerializable()
class DrinkUpdate{
  String? drinkName;
  String? drinkDescription;
  double? drinkCost;
  double? drinkAlcoholPerc;
  String? drinkImage;

  DrinkUpdate(this.drinkName, this.drinkDescription, this.drinkCost, this.drinkAlcoholPerc, this.drinkImage);
  factory DrinkUpdate.fromJson(Map<String, dynamic> json) => _$DrinkUpdateFromJson(json);

  /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$DrinkUpdateToJson(this);
}