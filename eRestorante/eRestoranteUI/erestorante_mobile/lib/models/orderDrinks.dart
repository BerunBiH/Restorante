import 'package:erestorante_mobile/models/role.dart';
import 'package:json_annotation/json_annotation.dart';

part 'orderDrinks.g.dart';

@JsonSerializable(explicitToJson: true)
class OrderDrinks{
  int? orderDrinkId;
  int? orderQuantity;
  int? orderId;
  int? drinkId;

  OrderDrinks(this.orderDrinkId, this.orderQuantity, this.orderId, this.drinkId);

  factory OrderDrinks.fromJson(Map<String, dynamic> json) => _$OrderDrinksFromJson(json);

  /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$OrderDrinksToJson(this);
}