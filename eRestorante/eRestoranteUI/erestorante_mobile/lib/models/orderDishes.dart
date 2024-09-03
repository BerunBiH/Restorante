import 'package:erestorante_mobile/models/role.dart';
import 'package:json_annotation/json_annotation.dart';

part 'orderDishes.g.dart';

@JsonSerializable(explicitToJson: true)
class OrderDishes{
  int? orderDishId;
  int? orderQuantity;
  int? orderId;

  OrderDishes(this.orderDishId, this.orderQuantity, this.orderId);

  factory OrderDishes.fromJson(Map<String, dynamic> json) => _$OrderDishesFromJson(json);

  /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$OrderDishesToJson(this);
}