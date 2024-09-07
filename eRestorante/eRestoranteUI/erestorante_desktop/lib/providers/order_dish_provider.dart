import 'package:erestorante_desktop/models/orderDishes.dart';
import 'package:erestorante_desktop/models/dish.dart';
import 'package:erestorante_desktop/providers/base_provider.dart';

class OrderDishesProvider extends BaseProvider<OrderDishes>{
  OrderDishesProvider(): super("OrderDishes");

  @override
  OrderDishes fromJson(data) {
    return OrderDishes.fromJson(data);
  }
}