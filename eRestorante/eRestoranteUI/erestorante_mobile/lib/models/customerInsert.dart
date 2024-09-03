import 'package:json_annotation/json_annotation.dart';

part 'customerInsert.g.dart';

@JsonSerializable()
class CustomerInsert{
  String? customerName;
  String? customerSurname;
  String? customerEmail;
  String? customerPhone;
  String? customerPassword;
  String? customerPasswordRepeat;
  String? customerImage;

  CustomerInsert(this.customerName, this.customerSurname, this.customerEmail, this.customerPhone, this.customerPassword, this.customerPasswordRepeat, this.customerImage);
  factory CustomerInsert.fromJson(Map<String, dynamic> json) => _$CustomerInsertFromJson(json);

  /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$CustomerInsertToJson(this);
}