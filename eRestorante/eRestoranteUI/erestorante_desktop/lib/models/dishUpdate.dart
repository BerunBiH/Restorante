import 'dart:ffi';

import 'package:json_annotation/json_annotation.dart';

part 'dishUpdate.g.dart';

@JsonSerializable()
class DishUpdate{
  String? dishName;
  String? dishDescription;
  double? dishCost;
  String? dishImage;
  bool? speciality;

  DishUpdate(this.dishName, this.dishDescription, this.dishCost, this.dishImage, this.speciality);
  factory DishUpdate.fromJson(Map<String, dynamic> json) => _$DishUpdateFromJson(json);

  /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$DishUpdateToJson(this);
}