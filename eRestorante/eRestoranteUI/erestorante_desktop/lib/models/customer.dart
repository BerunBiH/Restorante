import 'package:json_annotation/json_annotation.dart';

part 'customer.g.dart';

@JsonSerializable()
class Customer{
  int? customerId;
  String? customerName;
  String? customerSurname;
  String? customerEmail;
  String? customerPhone;
  String? customerDateRegister;
  String? customerImage;

  Customer(this.customerId, this.customerName, this.customerSurname, this.customerEmail, this.customerPhone, this.customerDateRegister, this.customerImage);
  factory Customer.fromJson(Map<String, dynamic> json) => _$CustomerFromJson(json);

  /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$CustomerToJson(this);
}