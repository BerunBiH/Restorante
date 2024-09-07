import 'package:erestorante_desktop/models/orderDrinks.dart';
import 'package:erestorante_desktop/models/dish.dart';
import 'package:erestorante_desktop/providers/base_provider.dart';

class OrderDrinksProvider extends BaseProvider<OrderDrinks>{
  OrderDrinksProvider(): super("OrderDrinks");

  @override
  OrderDrinks fromJson(data) {
    return OrderDrinks.fromJson(data);
  }
}