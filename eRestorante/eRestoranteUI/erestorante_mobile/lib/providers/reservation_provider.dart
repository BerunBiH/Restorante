import 'package:erestorante_mobile/models/reservation.dart';
import 'package:erestorante_mobile/providers/base_provider.dart';

class ReservationProvider extends BaseProvider<Reservation>{
  ReservationProvider(): super("Reservation");

  @override
  Reservation fromJson(data) {
    return Reservation.fromJson(data);
  }
}