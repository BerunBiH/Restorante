import 'package:cross_scroll/cross_scroll.dart';
import 'package:erestorante_mobile/models/reservation.dart';
import 'package:erestorante_mobile/models/reservationUpdate.dart';
import 'package:erestorante_mobile/models/search_result.dart';
import 'package:erestorante_mobile/models/user.dart';
import 'package:erestorante_mobile/providers/reservation_provider.dart';
import 'package:erestorante_mobile/providers/user_provider.dart';
import 'package:erestorante_mobile/screens/reservation_add_screen.dart';
// import 'package:erestorante_mobile/screens/customer_screen.dart';
import 'package:erestorante_mobile/utils/util.dart';
import 'package:erestorante_mobile/widgets/master_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ReservationScreen extends StatefulWidget {
  const ReservationScreen({super.key});

  @override
  State<ReservationScreen> createState() => _ReservationScreenState();
}

class _ReservationScreenState extends State<ReservationScreen> {
  final TextEditingController _searchController = TextEditingController();
  late ReservationProvider _reservationProvider;
  SearchResult<Reservation>? resultR;
  bool _isLoading = true;
 @override
  void initState() {
    super.initState();
    _reservationProvider = context.read<ReservationProvider>();
    _loadData();
  }
  Future<void> _loadData() async {
    var dataR = await _reservationProvider.get(filter: {
            'CustomerId': Info.id
          });
    setState(() {
      resultR = dataR;
      _isLoading = false;
    });
  }


  @override
  Widget build(BuildContext context) {
    return MasterScreenWidget(isJelovnikPressed: false,
    isKorpaPressed: false,
    isMojProfilPressed: false,
    isPostavkePressed: false,
    isRecenzijePressed: false,
    isRezervacijePressed: true,
      child: (_isLoading) ?
      Center(child: CircularProgressIndicator()):
      _buildAuthorisation()
    );
  }

    Container _buildAuthorisation() {
    return Container(
        child:
        Column(
          children: [ 
            _buildSearch(),
            (resultR!.result!=null && resultR!.result.isNotEmpty)?
            _buildDataListView():
            Text("Nema rezervacija za ovog korisnika."),
          ],
        ),
    );
  }

  Widget _buildSearch() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
      Expanded(
        child: Card(
          child: SingleChildScrollView(
              padding: const EdgeInsets.all(20.0),
   child: Column(
  children: [
    GestureDetector(
      onTap: () async {
        DateTime? pickedDate = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(2000),
          lastDate: DateTime(2100),
        );

        if (pickedDate != null) {
          String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
          _searchController.text = formattedDate;

          var data = await _reservationProvider.get(filter: {
            'ReservationDate': _searchController.text,
            'CustomerId': Info.id,
          });

          setState(() {
            resultR = data;
          });
        }
      },
      child: AbsorbPointer(
        child: TextField(
          decoration: const InputDecoration(
            labelText: 'Pretraga',
            hintText: 'Pretrazite po datumu rezervacije.',
            border: OutlineInputBorder(),
            prefixIcon: Icon(Icons.date_range),
          ),
          controller: _searchController,
        ),
      ),
    ),
    const SizedBox(height: 20.0),
    const Text("Pretrazite po datumu rezervacije."),
     const SizedBox(height: 20.0),
          Center(
            child: Row(
              children: [
                ElevatedButton(
                        onPressed: () async {
                
                if(_searchController.text.isEmpty)
                  {
                    return;
                  }
                
                  var data = await _reservationProvider.get(filter: {
            'CustomerId': Info.id
          });
                  
                setState(() {
                  _searchController.text = "";
                  resultR = data;
                });
                },
                        child: Text('Obriši pretragu'),
                        style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                overlayColor: Colors.green,
                padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
                        ),
                      ),
                      SizedBox(width: 20.0,),
                      ElevatedButton(
                        onPressed: () async {
                          Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                builder: (context) => ReservationAddScreen(),
                                                              ),
                                                            );
                },
                        child: Text('Kreiraj novu rezervaciju'),
                        style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                overlayColor: Colors.green,
                padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
                        ),
                      ),
                      
              ],
            ),
          ),
    const SizedBox(height: 5.0),
  ],
),
          )
        )
      ),
    ],
    );
  }

  Widget _buildDataListView() {
    return Expanded(
        child:CrossScroll(
        child: 
        DataTable(
        showCheckboxColumn: false,  
        columns: [
                      const DataColumn(
          label: Expanded(
          child: Text(
            'Status rezervacije',
            style: TextStyle(fontStyle: FontStyle.italic),
           ),
           ),
            ),
            const DataColumn(
          label: Expanded(
          child: Text(
            'Datum rezervacije',
            style: TextStyle(fontStyle: FontStyle.italic),
           ),
           ),
            ),
            const DataColumn(
          label: Expanded(
          child: Text(
            'Vrijeme rezervacije',
            style: TextStyle(fontStyle: FontStyle.italic),
           ),
           ),
            ),
            const DataColumn(
          label: Expanded(
          child: Text(
            'Trajanje rezervacije',
            style: TextStyle(fontStyle: FontStyle.italic),
           ),
           ),
            ),
            const DataColumn(
          label: Expanded(
          child: Text(
            'Broj gostiju',
            style: TextStyle(fontStyle: FontStyle.italic),
           ),
           ),
            ),
            const DataColumn(
          label: Expanded(
          child: Text(
            'Broj djece',
            style: TextStyle(fontStyle: FontStyle.italic),
           ),
           ),
            ),
            const DataColumn(
          label: Expanded(
          child: Text(
            'Specijalne želje',
            style: TextStyle(fontStyle: FontStyle.italic),
           ),
           ),
            ),
            const DataColumn(
          label: Expanded(
          child: Text(
            'Uredi rezervaciju',
            style: TextStyle(fontStyle: FontStyle.italic),
           ),
           ),
            ),
            const DataColumn(
          label: Expanded(
          child: Text(
            'Izbriši rezervaciju',
            style: TextStyle(fontStyle: FontStyle.italic),
           ),
           ),
            )
      ], 
      rows: resultR?.result.map((Reservation e)=>
        DataRow(onSelectChanged: (selected) => {
          if(selected==true)
          {
            
          }
        },
        color: WidgetStateProperty.resolveWith<Color?>(
        (Set<WidgetState> states) {
          if (e.reservationStatus == 1) {
            return Colors.green.withOpacity(0.2); 
          } else if (e.reservationStatus == 2) {
            return Colors.red.withOpacity(0.2); 
          }
          return null; 
        },
      ),
          cells: [
            DataCell(Text(
              e.reservationStatus == 0
                  ? "Rezervacija nije pregledana"
                  : e.reservationStatus == 1
                      ? "Rezervacija odobrena"
                      : e.reservationStatus == 2
                          ? "Rezervacija odbijena"
                          : "Nepoznat status",
              ),
            ),
            DataCell(Text(e.reservationDate ?? "")),
            DataCell(Text(e.reservationTime ?? "")),
            DataCell(Text(e.numberOfHours.toString() ?? "")),
            DataCell(Text(e.numberOfGuests.toString() ?? "")),
            DataCell(Text(e.numberOfMinors.toString() ?? "")),
            DataCell(Text(e.specialWishes ?? "")),
            DataCell(IconButton(
            icon: Icon(Icons.edit),     
            onPressed: () {
              if(e.reservationStatus!=0)
              {
                showDialog(
                  barrierDismissible: false,
                  context: context,
                  builder: (BuildContext context) {
                    return StatefulBuilder(
                      builder: (context, setState) {
                        return AlertDialog(
                          title: Text(
                            "Greška!",
                            textAlign: TextAlign.center,
                          ),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                "Ne možete urediti rezervaciju koja je odobrena ili odbijena.",
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
                return;
              }
             showDialog(
              barrierDismissible: false,
                                      context: context,
                                      builder: (BuildContext context) {
                                        return StatefulBuilder(
                                          builder: (context, setState) {
                                            return AlertDialog(
                                              title: Text(
                                                "Da li ste sigurni da želite urediti rezervaciju?",
                                                textAlign: TextAlign.center,
                                              ),
                                              content: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Text(
                                                    "Ako želite urediti rezervaciju pritisnite dugme ${"Uredi"} ako ne želite, pritisnite dugme ${"Odustani"}",
                                                    textAlign: TextAlign.center,
                                                  ),
                                                  SizedBox(height: 20),
                                                ],
                                              ),
                                              actions: [
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                                                  children: [
                                                    ElevatedButton(
                                                                                                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          overlayColor: Colors.green,
                          surfaceTintColor: Color.fromARGB(255, 16, 190, 69),
                          padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
                        ),
                                                      onPressed: () {
                                                         Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                builder: (context) => ReservationAddScreen(reservation: e),
                                                              ),
                                                            );
                                                      },
                                                      child: const Text("Uredi"),
                                                    ),SizedBox(width: 10,),
                                                                                                    ElevatedButton(
                                                                                                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          overlayColor: Colors.red,
                          surfaceTintColor: const Color.fromARGB(255, 255, 0, 0),
                          padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
                        ),
                                                      onPressed: () {
                                                        Navigator.pop(context);
                                                      },
                                                      child: const Text("Odustani"),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            );
                                          },
                                        );
                                      },
                                    );
            },
          ),),
            DataCell(IconButton(
            icon: Icon(Icons.delete),
            color: Colors.red,      
            onPressed: () {
             showDialog(
              barrierDismissible: false,
                                      context: context,
                                      builder: (BuildContext context) {
                                        return StatefulBuilder(
                                          builder: (context, setState) {
                                            return AlertDialog(
                                              title: Text(
                                                "Da li ste sigurni da želite izbrisati rezervaciju?",
                                                textAlign: TextAlign.center,
                                              ),
                                              content: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Text(
                                                    "Ako želite izbrisati rezervaciju pritisnite dugme ${"Izbriši"} ako ne želite, pritisnite dugme ${"Odustani"}",
                                                    textAlign: TextAlign.center,
                                                  ),
                                                  SizedBox(height: 20),
                                                ],
                                              ),
                                              actions: [
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                                                  children: [
                                                    ElevatedButton(
                                                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          overlayColor: Colors.green,
                          padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
                        ),
                                                      onPressed: () async {
                                                        await _reservationProvider.delete(e.reservationId!);
                                                        showDialog(
                                                          barrierDismissible: false,
                                      context: context,
                                      builder: (BuildContext context) {
                                        return StatefulBuilder(
                                          builder: (context, setState) {
                                            return AlertDialog(
                                              title: Text(
                                                "Uspješno izbrisana rezervacija",
                                                textAlign: TextAlign.center,
                                              ),
                                              content: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Text(
                                                    "Uspješno ste izbrisali rezervaciju!",
                                                    textAlign: TextAlign.center,
                                                  ),
                                                  SizedBox(height: 20),
                                                ],
                                              ),
                                              actions: [
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                                                  children: [
                                                    ElevatedButton(
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
                                                  ],
                                                ),
                                              ],
                                            );
                                          },
                                        );
                                      },
                                    );
                                                      },
                                                      child: const Text("Izbriši"),
                                                    ),
                                                    SizedBox(width: 10,),
                                                                                                    ElevatedButton(
                                                                                                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          overlayColor: Colors.red,
                          surfaceTintColor: const Color.fromARGB(255, 255, 0, 0),
                          padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
                        ),
                                                      onPressed: () {
                                                        Navigator.pop(context);
                                                      },
                                                      child: const Text("Odustani"),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            );
                                          },
                                        );
                                      },
                                    );
            },
          ),),
          ] 
        )
      ).toList() ?? []
      ),
      )
      );
  }

}