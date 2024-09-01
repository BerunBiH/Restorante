import 'dart:ffi';

import 'package:erestorante_desktop/models/commentDish.dart';
import 'package:erestorante_desktop/models/orderDishes.dart';
import 'package:erestorante_desktop/models/ratingDishes.dart';
import 'package:json_annotation/json_annotation.dart';

part 'dish.g.dart';

@JsonSerializable(explicitToJson: true)
class Dish{
  int? dishID;
  String? dishName;
  String? dishDescription;
  double? dishCost;
  int? categoryId;
  String? dishImage;
  bool? speciality;
  List<CommentDish>? commentDishes;
  List<OrderDishes>? orderDishes;
  List<RatingDishes>? ratingDishes;

  Dish(this.dishID, this.dishName, this.dishDescription, this.dishCost, this.categoryId, this.dishImage, this.speciality, this.commentDishes, this.ratingDishes, this.orderDishes);
  factory Dish.fromJson(Map<String, dynamic> json) => _$DishFromJson(json);

  /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$DishToJson(this);
}