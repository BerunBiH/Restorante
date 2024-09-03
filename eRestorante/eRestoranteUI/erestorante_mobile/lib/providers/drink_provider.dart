import 'package:erestorante_mobile/models/drink.dart';
import 'package:erestorante_mobile/providers/base_provider.dart';

class DrinkProvider extends BaseProvider<Drink>{
  DrinkProvider(): super("Drink");

  @override
  Drink fromJson(data) {
    return Drink.fromJson(data);
  }
}