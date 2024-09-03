import 'package:erestorante_mobile/models/role.dart';
import 'package:json_annotation/json_annotation.dart';

part 'commentDish.g.dart';

@JsonSerializable(explicitToJson: true)
class CommentDish{
  int? commentDishId;
  String? commentDate;
  String? commentText;

  CommentDish(this.commentDishId, this.commentDate, this.commentText);

  factory CommentDish.fromJson(Map<String, dynamic> json) => _$CommentDishFromJson(json);

  /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$CommentDishToJson(this);
}