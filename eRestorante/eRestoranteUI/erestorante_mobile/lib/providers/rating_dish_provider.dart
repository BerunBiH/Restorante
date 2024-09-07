import 'package:erestorante_mobile/models/commentDish.dart';
import 'package:erestorante_mobile/models/dish.dart';
import 'package:erestorante_mobile/models/ratingDishes.dart';
import 'package:erestorante_mobile/providers/base_provider.dart';

class RatingDishProvider extends BaseProvider<RatingDishes>{
  RatingDishProvider(): super("RatingDish");

  @override
  RatingDishes fromJson(data) {
    return RatingDishes.fromJson(data);
  }
}