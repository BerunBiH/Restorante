import 'package:erestorante_desktop/models/orderDrinks.dart';
import 'package:json_annotation/json_annotation.dart';

part 'orderInsert.g.dart';

@JsonSerializable(explicitToJson: true)
class OrderInsert{
  int? customerId;

  OrderInsert(this.customerId);
  factory OrderInsert.fromJson(Map<String, dynamic> json) => _$OrderInsertFromJson(json);

  /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$OrderInsertToJson(this);
}