import 'package:erestorante_mobile/models/role.dart';
import 'package:json_annotation/json_annotation.dart';

part 'orderDishInsert.g.dart';

@JsonSerializable(explicitToJson: true)
class OrderDishInsert{
  int? orderQuantity;
  int? orderId;
  int? dishId;

  OrderDishInsert(this.orderQuantity, this.orderId, this.dishId);

  factory OrderDishInsert.fromJson(Map<String, dynamic> json) => _$OrderDishInsertFromJson(json);

  /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$OrderDishInsertToJson(this);
}