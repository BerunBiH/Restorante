import 'dart:ffi';

import 'package:json_annotation/json_annotation.dart';

part 'drink.g.dart';

@JsonSerializable()
class Drink{
  int? drinkId;
  String? drinkName;
  String? drinkDescription;
  double? drinkCost;
  int? drinkAlcoholPerc;
  String? drinkImage;
  int? categoryId;

  Drink(this.drinkId, this.drinkName, this.drinkDescription, this.drinkCost, this.drinkAlcoholPerc, this.drinkImage, this.categoryId);
  factory Drink.fromJson(Map<String, dynamic> json) => _$DrinkFromJson(json);

  /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$DrinkToJson(this);
}