import 'package:erestorante_mobile/models/commentDish.dart';
import 'package:erestorante_mobile/models/dish.dart';
import 'package:erestorante_mobile/providers/base_provider.dart';

class CommentDishProvider extends BaseProvider<CommentDish>{
  CommentDishProvider(): super("CommentDish");

  @override
  CommentDish fromJson(data) {
    return CommentDish.fromJson(data);
  }
}