
import 'package:json_annotation/json_annotation.dart';

part 'drinkInsert.g.dart';

@JsonSerializable()
class DrinkInsert{
  String? drinkName;
  String? drinkDescription;
  double? drinkCost;
  double? drinkAlcoholPerc;
  String? drinkImage;
  int? categoryId;

  DrinkInsert(this.drinkName, this.drinkDescription, this.drinkCost, this.drinkAlcoholPerc, this.drinkImage, this.categoryId);
  factory DrinkInsert.fromJson(Map<String, dynamic> json) => _$DrinkInsertFromJson(json);

  /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$DrinkInsertToJson(this);
}