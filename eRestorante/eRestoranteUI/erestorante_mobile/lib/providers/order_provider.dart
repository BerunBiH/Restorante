import 'package:erestorante_mobile/models/orders.dart';
import 'package:erestorante_mobile/models/dish.dart';
import 'package:erestorante_mobile/providers/base_provider.dart';

class OrderProvider extends BaseProvider<Order>{
  OrderProvider(): super("Order");

  @override
  Order fromJson(data) {
    return Order.fromJson(data);
  }
}