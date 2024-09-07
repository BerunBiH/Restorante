import 'package:json_annotation/json_annotation.dart';

part 'orderDishes.g.dart';

@JsonSerializable(explicitToJson: true)
class OrderDishes {
  int? orderDishId;
  int? orderQuantity;
  int? orderId;
  int? dishId;

  OrderDishes(this.orderDishId, this.orderQuantity, this.orderId, this.dishId);

  factory OrderDishes.fromJson(Map<String, dynamic> json) => _$OrderDishesFromJson(json);

  Map<String, dynamic> toJson() => _$OrderDishesToJson(this);
}
