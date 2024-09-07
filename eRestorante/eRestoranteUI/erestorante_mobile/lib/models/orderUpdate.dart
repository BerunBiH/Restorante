import 'package:json_annotation/json_annotation.dart';

part 'orderUpdate.g.dart';

@JsonSerializable(explicitToJson: true)
class OrderUpdate{
  int? orderStatus;
  int? orderNullified;

  OrderUpdate(this.orderNullified, this.orderStatus);
  factory OrderUpdate.fromJson(Map<String, dynamic> json) => _$OrderUpdateFromJson(json);

  /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$OrderUpdateToJson(this);
}