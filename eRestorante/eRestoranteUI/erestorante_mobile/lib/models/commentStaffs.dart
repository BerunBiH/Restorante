import 'package:erestorante_mobile/models/role.dart';
import 'package:json_annotation/json_annotation.dart';

part 'commentStaffs.g.dart';

@JsonSerializable(explicitToJson: true)
class CommentStaffs{
  int? commentStaffId;
  int? userId;
  String? commentDate;
  String? commentText;

  CommentStaffs(this.commentStaffId, this.userId,this.commentDate, this.commentText);

  factory CommentStaffs.fromJson(Map<String, dynamic> json) => _$CommentStaffsFromJson(json);

  /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$CommentStaffsToJson(this);
}