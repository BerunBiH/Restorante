import 'package:erestorante_mobile/models/customer.dart';
import 'package:erestorante_mobile/providers/base_provider.dart';

class CustomerProvider extends BaseProvider<Customer>{
  CustomerProvider(): super("Customer");

  @override
  Customer fromJson(data) {
    return Customer.fromJson(data);
  }
}