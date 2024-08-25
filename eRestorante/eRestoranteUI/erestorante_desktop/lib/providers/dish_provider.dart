import 'package:erestorante_desktop/models/dish.dart';
import 'package:erestorante_desktop/providers/base_provider.dart';

class DishProvider extends BaseProvider<Dish>{
  DishProvider(): super("Dish");

  @override
  Dish fromJson(data) {
    return Dish.fromJson(data);
  }
}