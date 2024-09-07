import 'package:erestorante_desktop/models/orders.dart';
import 'package:erestorante_desktop/models/dish.dart';
import 'package:erestorante_desktop/providers/base_provider.dart';

class OrderProvider extends BaseProvider<Order>{
  OrderProvider(): super("Order");

  @override
  Order fromJson(data) {
    return Order.fromJson(data);
  }
}