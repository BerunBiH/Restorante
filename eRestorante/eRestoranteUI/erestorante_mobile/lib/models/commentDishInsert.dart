import 'package:erestorante_mobile/models/role.dart';
import 'package:json_annotation/json_annotation.dart';

part 'commentDishInsert.g.dart';

@JsonSerializable(explicitToJson: true)
class CommentDishInsert{
  int? dishId;
  int? userId;
  String? commentText;

  CommentDishInsert(this.dishId, this.userId, this.commentText);

  factory CommentDishInsert.fromJson(Map<String, dynamic> json) => _$CommentDishInsertFromJson(json);

  /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$CommentDishInsertToJson(this);
}