import 'package:erestorante_desktop/models/customer.dart';
import 'package:erestorante_desktop/providers/base_provider.dart';

class CustomerProvider extends BaseProvider<Customer>{
  CustomerProvider(): super("Customer");

  @override
  Customer fromJson(data) {
    return Customer.fromJson(data);
  }
}