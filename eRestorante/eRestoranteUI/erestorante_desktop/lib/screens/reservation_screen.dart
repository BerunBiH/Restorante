import 'package:cross_scroll/cross_scroll.dart';
import 'package:erestorante_desktop/models/reservation.dart';
import 'package:erestorante_desktop/models/reservationUpdate.dart';
import 'package:erestorante_desktop/models/search_result.dart';
import 'package:erestorante_desktop/models/user.dart';
import 'package:erestorante_desktop/providers/reservation_provider.dart';
import 'package:erestorante_desktop/providers/user_provider.dart';
import 'package:erestorante_desktop/screens/customer_screen.dart';
import 'package:erestorante_desktop/utils/util.dart';
import 'package:erestorante_desktop/widgets/master_screen.dart';
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
  late UserProvider _userProvider;
  late ReservationProvider _reservationProvider;
  SearchResult<User>? resultU;
  SearchResult<Reservation>? resultR;
  bool authorised=false;
  bool _isLoading = true;
 @override
  void initState() {
    super.initState();
    _userProvider = context.read<UserProvider>();
    _reservationProvider = context.read<ReservationProvider>();
    _loadData();
  }
  Future<void> _loadData() async {
    var dataU = await _userProvider.get();
    var dataR = await _reservationProvider.get();

    setState(() {
      resultU = dataU;
      resultR = dataR;
      var user=resultU!.result.firstWhere((u)=> u.userEmail!.contains(Authorization.email!));
      if(user.userRoles![0].role!.roleName!="Menedzer")
      {
        authorised=false;
      }
      else{
        authorised=true;
      }
      _isLoading = false;
    });
  }


  @override
  Widget build(BuildContext context) {
    return MasterScreenWidget(isJelovnikPressed: false,
    isKorisniciPressed: false,
    isMojProfilPressed: false,
    isPostavkePressed: false,
    isRecenzijePressed: false,
    isRezervacijePressed: true,
    isUposleniciPressed: false,
      child: (_isLoading) ?
      Center(child: CircularProgressIndicator()):
      _buildAuthorisation()
    );
  }

    Container _buildAuthorisation() {
    return Container(
        child: (!authorised)? 
      Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Center(
          child: Container(
            width: 400,
            height: 100,
            padding: EdgeInsets.all(16.0),
            child: Card(
              elevation: 4.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Center(
                child: Text(
                  "Nemate privilegije da pristupite ovoj stranici.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    ): 
        Column(
          children: [ 
            _buildSearch(),
            _buildDataListView(),
          ],
        ),
    );
  }

  Widget _buildSearch() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
      Container(
        width: 1000,
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
            'ReservationDate': _searchController.text
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
          ElevatedButton(
        onPressed: () async {

          if(_searchController.text.isEmpty)
            {
              return;
            }

            var data = await _reservationProvider.get();
            
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
            'Ime korisnika',
            style: TextStyle(fontStyle: FontStyle.italic),
           ),
           ),
            ),
          const DataColumn(
          label: Expanded(
          child: Text(
            'Broj telefona za kontakt',
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
            'Status rezervacije',
            style: TextStyle(fontStyle: FontStyle.italic),
           ),
           ),
            ),
            const DataColumn(
          label: Expanded(
          child: Text(
            'Prihvati rezervaciju',
            style: TextStyle(fontStyle: FontStyle.italic),
           ),
           ),
            ),
             const DataColumn(
          label: Expanded(
          child: Text(
            'Odbij rezervaciju',
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
            DataCell(Text("${e.customer!.customerName} ${e.customer!.customerSurname}" ?? "")),
            DataCell(Text(e.contactPhone ?? "")),
            DataCell(Text(e.reservationDate ?? "")),
            DataCell(Text(e.reservationTime ?? "")),
            DataCell(Text(e.numberOfHours.toString() ?? "")),
            DataCell(Text(e.numberOfGuests.toString() ?? "")),
            DataCell(Text(e.numberOfMinors.toString() ?? "")),
            DataCell(Text(e.specialWishes ?? "")),
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
            DataCell(IconButton(
            icon: Icon(Icons.check),
            color: Colors.green,      
            onPressed: () {
              if(e.reservationStatus==1)
                return;
             showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return StatefulBuilder(
                                          builder: (context, setState) {
                                            return AlertDialog(
                                              title: Text(
                                                "Da li ste sigurni da želite prihvatiti rezervaciju?",
                                                textAlign: TextAlign.center,
                                              ),
                                              content: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Text(
                                                    "Ako želite prihvatiti rezervaciju pritisnite dugme ${"Prihvati"} ako ne želite, pritisnite dugme ${"Odustani"}",
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
                                                        ReservationUpdate res = new ReservationUpdate(e.reservationDate, e.reservationTime, e.numberOfGuests, e.numberOfHours, 1, e.reservationReason, e.numberOfMinors, e.contactPhone, e.specialWishes);
                                                        await _reservationProvider.update(e.reservationId!,res);
                                                        showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return StatefulBuilder(
                                          builder: (context, setState) {
                                            return AlertDialog(
                                              title: Text(
                                                "Uspješno prihvaćena rezervacija",
                                                textAlign: TextAlign.center,
                                              ),
                                              content: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Text(
                                                    "Uspješno ste prihvatili odabranu rezervaciju!",
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
                                                      child: const Text("Prihvati"),
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
            DataCell(IconButton(
            icon: Icon(Icons.close_sharp),
            color: Colors.redAccent,      
            onPressed: () {
              if(e.reservationStatus==2)
                return;
             showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return StatefulBuilder(
                                          builder: (context, setState) {
                                            return AlertDialog(
                                              title: Text(
                                                "Da li ste sigurni da želite odbiti rezervaciju?",
                                                textAlign: TextAlign.center,
                                              ),
                                              content: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Text(
                                                    "Ako želite odbiti rezervaciju pritisnite dugme ${"Odbij"} ako ne želite, pritisnite dugme ${"Odustani"}",
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
                                                        ReservationUpdate res = new ReservationUpdate(e.reservationDate, e.reservationTime, e.numberOfGuests, e.numberOfHours, 2, e.reservationReason, e.numberOfMinors, e.contactPhone, e.specialWishes);
                                                        await _reservationProvider.update(e.reservationId!,res);
                                                        showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return StatefulBuilder(
                                          builder: (context, setState) {
                                            return AlertDialog(
                                              title: Text(
                                                "Uspješno odbijena rezervacija",
                                                textAlign: TextAlign.center,
                                              ),
                                              content: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Text(
                                                    "Uspješno ste odbili odabranu rezervaciju!",
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
                                                      child: const Text("Odbij"),
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
            DataCell(IconButton(
            icon: Icon(Icons.delete),
            color: Colors.red,      
            onPressed: () {
             showDialog(
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