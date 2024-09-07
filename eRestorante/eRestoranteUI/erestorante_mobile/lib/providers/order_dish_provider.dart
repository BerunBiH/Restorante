import 'package:erestorante_mobile/models/orderDishes.dart';
import 'package:erestorante_mobile/models/dish.dart';
import 'package:erestorante_mobile/providers/base_provider.dart';

class OrderDishesProvider extends BaseProvider<OrderDishes>{
  OrderDishesProvider(): super("OrderDishes");

  @override
  OrderDishes fromJson(data) {
    return OrderDishes.fromJson(data);
  }
}