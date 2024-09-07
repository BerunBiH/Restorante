import 'package:erestorante_mobile/models/orderDishes.dart';
import 'package:erestorante_mobile/models/orderDrinks.dart';
import 'package:json_annotation/json_annotation.dart';

part 'orders.g.dart';

@JsonSerializable(explicitToJson: true)
class Order{
  int? ordersId;
  int? orderNumber;
  String? orderDate;
  int? orderStatus;
  int? orderNullified;
  int? customerId;
  List<OrderDishes>? orderDishes;
  List<OrderDrinks>? orderDrinks;

  Order(this.ordersId, this.orderNumber, this.orderDate, this.orderStatus, this.orderNullified, this.customerId, this.orderDishes, this.orderDrinks);
  factory Order.fromJson(Map<String, dynamic> json) => _$OrderFromJson(json);

  /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$OrderToJson(this);
}