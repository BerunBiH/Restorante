import 'package:erestorante_mobile/models/role.dart';
import 'package:json_annotation/json_annotation.dart';

part 'commentStaffInsert.g.dart';

@JsonSerializable(explicitToJson: true)
class CommentStaffInsert{
  int? customerId;
  int? userId;
  String? commentText;

  CommentStaffInsert(this.customerId, this.userId, this.commentText);

  factory CommentStaffInsert.fromJson(Map<String, dynamic> json) => _$CommentStaffInsertFromJson(json);

  /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$CommentStaffInsertToJson(this);
}