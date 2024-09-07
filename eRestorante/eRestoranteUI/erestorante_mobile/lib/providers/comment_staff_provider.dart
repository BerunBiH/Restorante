import 'package:erestorante_mobile/models/commentDish.dart';
import 'package:erestorante_mobile/models/commentStaffs.dart';
import 'package:erestorante_mobile/models/dish.dart';
import 'package:erestorante_mobile/providers/base_provider.dart';

class CommentStaffProvider extends BaseProvider<CommentStaffs>{
  CommentStaffProvider(): super("CommentStaff");

  @override
  CommentStaffs fromJson(data) {
    return CommentStaffs.fromJson(data);
  }
}