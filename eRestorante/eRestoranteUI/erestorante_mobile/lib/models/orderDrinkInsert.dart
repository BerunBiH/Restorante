import 'package:erestorante_mobile/models/role.dart';
import 'package:json_annotation/json_annotation.dart';

part 'orderDrinkInsert.g.dart';

@JsonSerializable(explicitToJson: true)
class OrderDrinkInsert{
  int? orderQuantity;
  int? orderId;
  int? drinkId;

  OrderDrinkInsert(this.orderQuantity, this.orderId, this.drinkId);

  factory OrderDrinkInsert.fromJson(Map<String, dynamic> json) => _$OrderDrinkInsertFromJson(json);

  /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$OrderDrinkInsertToJson(this);
}