import 'package:erestorante_mobile/models/orderDrinks.dart';
import 'package:erestorante_mobile/models/dish.dart';
import 'package:erestorante_mobile/providers/base_provider.dart';

class OrderDrinksProvider extends BaseProvider<OrderDrinks>{
  OrderDrinksProvider(): super("OrderDrinks");

  @override
  OrderDrinks fromJson(data) {
    return OrderDrinks.fromJson(data);
  }
}