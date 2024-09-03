import 'package:json_annotation/json_annotation.dart';

part 'customerUpdate.g.dart';

@JsonSerializable()
class CustomerUpdate{
  String? customerName;
  String? customerSurname;
  String? customerEmail;
  String? customerPhone;
  String? customerPassword;
  String? customerPasswordRepeat;
  String? customerImage;

  CustomerUpdate(this.customerName, this.customerSurname, this.customerEmail, this.customerPhone, this.customerPassword, this.customerPasswordRepeat,this.customerImage);
  factory CustomerUpdate.fromJson(Map<String, dynamic> json) => _$CustomerUpdateFromJson(json);

  /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$CustomerUpdateToJson(this);
}