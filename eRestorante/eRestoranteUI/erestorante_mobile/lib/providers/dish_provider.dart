import 'package:erestorante_mobile/models/dish.dart';
import 'package:erestorante_mobile/providers/base_provider.dart';

class DishProvider extends BaseProvider<Dish>{
  DishProvider(): super("Dish");

  @override
  Dish fromJson(data) {
    return Dish.fromJson(data);
  }
}