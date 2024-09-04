import 'package:erestorante_mobile/models/customer.dart';
import 'package:erestorante_mobile/models/reservation.dart';
import 'package:erestorante_mobile/models/reservationInsert.dart';
import 'package:erestorante_mobile/models/reservationUpdate.dart';
import 'package:erestorante_mobile/models/search_result.dart';
import 'package:erestorante_mobile/providers/reservation_provider.dart';
import 'package:erestorante_mobile/screens/reservation_screen.dart';
import 'package:erestorante_mobile/utils/util.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:erestorante_mobile/providers/customer_provider.dart';

class ReservationAddScreen extends StatefulWidget {
  Reservation? reservation;
  ReservationAddScreen({super.key, this.reservation});

  @override
  State<ReservationAddScreen> createState() => _ReservationAddScreenState();
}

class _ReservationAddScreenState extends State<ReservationAddScreen> {
  final TextEditingController _reservationDateController = TextEditingController();
  final TextEditingController _reservationTimeController = TextEditingController();
  final TextEditingController _numberOfGuestsController = TextEditingController();
  final TextEditingController _numberOfHoursController = TextEditingController();
  final TextEditingController _reservationReasonController = TextEditingController();
  final TextEditingController _numberOfMinorsController = TextEditingController();
  final TextEditingController _contactPhoneController = TextEditingController();
  final TextEditingController _specialWishesController = TextEditingController();

  late CustomerProvider _customerProvider;
  late Customer customer;
  late ReservationProvider _reservationProvider;
  SearchResult<Reservation>? resultR;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _customerProvider = context.read<CustomerProvider>();
    _reservationProvider = context.read<ReservationProvider>();

    // Prefill the fields if reservation exists
    if (widget.reservation != null) {
      _reservationDateController.text = widget.reservation!.reservationDate!;
      _reservationTimeController.text = widget.reservation!.reservationTime!;
      _numberOfGuestsController.text = widget.reservation!.numberOfGuests.toString();
      _numberOfHoursController.text = widget.reservation!.numberOfHours.toString();
      _reservationReasonController.text = widget.reservation!.reservationReason!;
      _numberOfMinorsController.text = widget.reservation!.numberOfMinors.toString();
      _contactPhoneController.text = widget.reservation!.contactPhone!;
      _specialWishesController.text = widget.reservation!.specialWishes!;
    }

    _loadData();
  }

  Future<void> _loadData() async {
    var dataU = await _customerProvider.get();
    setState(() {
      customer = dataU.result.firstWhere((x) => x.customerId == Info.id);
      _isLoading = false;
    });
  }

  bool _validateReservationDate(String date) {
    return date.isNotEmpty;
  }

  bool _validateReservationTime(String time) {
    return time.isNotEmpty;
  }

  bool _validateNumberOfGuests(int guests) {
    return guests >= 1 && guests <= 100;
  }

  bool _validateNumberOfHours(int hours) {
    return hours > 0 && hours <= 16;
  }

  bool _validateReservationReason(String reason) {
    return reason.length <= 1000;
  }

  bool _validateNumberOfMinors(int minors) {
    return minors >= 0 && minors <= 100;
  }

  bool _validateContactPhone(String phone) {
    return phone.isNotEmpty;
  }

  bool _validateSpecialWishes(String wishes) {
    return wishes.length <= 1000;
  }

  Future<void> _submitReservation() async {
    if (!_validateReservationDate(_reservationDateController.text) ||
        !_validateReservationTime(_reservationTimeController.text) ||
        !_validateNumberOfGuests(int.parse(_numberOfGuestsController.text)) ||
        !_validateNumberOfHours(int.parse(_numberOfHoursController.text)) ||
        !_validateReservationReason(_reservationReasonController.text) ||
        !_validateNumberOfMinors(int.parse(_numberOfMinorsController.text)) ||
        !_validateContactPhone(_contactPhoneController.text) ||
        !_validateSpecialWishes(_specialWishesController.text)) {
       showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(
            builder: (context, setState) {
              return AlertDialog(
                title: Text(
                  "Upss, nešto nije okay!",
                  textAlign: TextAlign.center,
                ),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Izgleda da nešto niste popunili kako treba, probajte opet sa svim popunjenim poljima i ispravnim podacima!",
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
                actions: [
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text("Ok"),
                    ),
                  ),
                ],
              );
            },
          );
        },
      );
      return;
    }
    try{
      if(widget.reservation==null)
      {
        ReservationInsert res = ReservationInsert(_reservationDateController.text, _reservationTimeController.text, int.parse(_numberOfGuestsController.text), int.parse(_numberOfHoursController.text), 0, Info.id,_reservationReasonController.text, int.parse(_numberOfMinorsController.text), _contactPhoneController.text, _specialWishesController.text);
        await _reservationProvider.insert(res);
      }
      else
      {
        ReservationUpdate res = ReservationUpdate(_reservationDateController.text, _reservationTimeController.text, int.parse(_numberOfGuestsController.text), int.parse(_numberOfHoursController.text), 0,_reservationReasonController.text, int.parse(_numberOfMinorsController.text), _contactPhoneController.text, _specialWishesController.text);
        await _reservationProvider.update(widget.reservation!.reservationId!,res);
      }
    }
    catch(e){
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(
            builder: (context, setState) {
              return AlertDialog(
                title: Text(
                  "Upss, nešto nije okay!",
                  textAlign: TextAlign.center,
                ),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Nešto se nije spremilo okay! Provjerite svoju konekciju pa probajte opet!",
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
                actions: [
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text("Ok"),
                    ),
                  ),
                ],
              );
            },
          );
        },
      );
    }
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(
            builder: (context, setState) {
              return AlertDialog(
                title: Text(
                  "Uspješno dodana rezervacija!",
                  textAlign: TextAlign.center,
                ),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Uspjesno ste dodali novu rezervaciju, dobili ste mail potvrde! Uskoro će naš tim da Vam potvrdi ili onemoguci rezervaciju.",
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
                actions: [
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ReservationScreen(),
                          ),
                        );
                      },
                      child: const Text("Ok"),
                    ),
                  ),
                ],
              );
            },
          );
        },
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Reservation'),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    _buildDatePicker(
                      controller: _reservationDateController,
                      labelText: 'Datum rezervacije',
                    ),
                    SizedBox(height: 10),
                    _buildTimePicker(
                      controller: _reservationTimeController,
                      labelText: 'Vrijeme rezervacije',
                    ),
                    SizedBox(height: 10),
                    _buildNumberField(
                      controller: _numberOfGuestsController,
                      labelText: 'Broj gostiju (ne manje od 1 i vece od 100)',
                      max: 100,
                    ),
                    SizedBox(height: 10),
                    _buildNumberField(
                      controller: _numberOfHoursController,
                      labelText: 'Broj sati (ne manje od 1 i vece od 16)',
                      max: 16,
                    ),
                    SizedBox(height: 10),
                    _buildTextField(
                      controller: _reservationReasonController,
                      labelText: 'Razlog rezervacije barem 1 slovo i max 1000 slova',
                      maxLength: 1000,
                    ),
                    SizedBox(height: 10),
                    _buildNumberField(
                      controller: _numberOfMinorsController,
                      labelText: 'Broj maloljetnika (ne manje od 0 i vece od 100)',
                      max: 100,
                    ),
                    SizedBox(height: 10),
                    _buildNumberField(
                      controller: _contactPhoneController,
                      labelText: 'Kontakt telefon (ne vise od 20 znamenki)',
                      max: 20,
                    ),
                    SizedBox(height: 10),
                    _buildTextField(
                      controller: _specialWishesController,
                      labelText: 'Specijalne zelje (ne više od 1000 znakova)',
                      maxLength: 1000,
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: _submitReservation,
                      child: Text('Posaljite rezervaciju'),
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  Widget _buildDatePicker({required TextEditingController controller, required String labelText}) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(labelText: labelText),
      onTap: () async {
        DateTime? date = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(2000),
          lastDate: DateTime(2101),
        );
        if (date != null) {
          controller.text = date.toString().split(' ')[0];
        }
      },
      readOnly: true,
    );
  }

Widget _buildTimePicker({required TextEditingController controller, required String labelText}) {
  return TextField(
    controller: controller,
    decoration: InputDecoration(labelText: labelText),
    onTap: () async {
      TimeOfDay? time = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );
      if (time != null) {
        final formattedTime = time.hour.toString().padLeft(2, '0') + ':' +
                              time.minute.toString().padLeft(2, '0') + ':00';
        controller.text = formattedTime; // Format to HH:mm:ss
      }
    },
    readOnly: true,
  );
}


  Widget _buildNumberField({
    required TextEditingController controller,
    required String labelText,
    required int max,
  }) {
    return TextField(
      controller: controller,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(labelText: labelText),
      inputFormatters: [
      ],
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String labelText,
    int? maxLength,
  }) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(labelText: labelText),
      maxLength: maxLength,
    );
  }
}
