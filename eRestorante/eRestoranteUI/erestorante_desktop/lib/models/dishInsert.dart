import 'dart:ffi';

import 'package:json_annotation/json_annotation.dart';

part 'dishInsert.g.dart';

@JsonSerializable()
class DishInsert{
  String? dishName;
  String? dishDescription;
  double? dishCost;
  int? categoryId;
  String? dishImage;

  DishInsert(this.dishName, this.dishDescription, this.dishCost, this.categoryId, this.dishImage);
  factory DishInsert.fromJson(Map<String, dynamic> json) => _$DishInsertFromJson(json);

  /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$DishInsertToJson(this);
}