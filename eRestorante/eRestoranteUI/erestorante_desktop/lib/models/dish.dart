import 'dart:ffi';

import 'package:json_annotation/json_annotation.dart';

part 'dish.g.dart';

@JsonSerializable()
class Dish{
  int? dishID;
  String? dishName;
  String? dishDescription;
  double? dishCost;
  int? categoryID;
  String? dishImage;

  Dish(this.dishID, this.dishName, this.dishDescription, this.dishCost, this.categoryID, this.dishImage);
  factory Dish.fromJson(Map<String, dynamic> json) => _$DishFromJson(json);

  /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$DishToJson(this);
}