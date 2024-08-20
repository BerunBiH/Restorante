import 'package:json_annotation/json_annotation.dart';

part 'categoryC.g.dart';

@JsonSerializable()
class CategoryC{
  int? categoryId;
  String? categoryName;

  CategoryC(this.categoryId, this.categoryName);
  factory CategoryC.fromJson(Map<String, dynamic> json) => _$CategoryCFromJson(json);

  /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$CategoryCToJson(this);
}