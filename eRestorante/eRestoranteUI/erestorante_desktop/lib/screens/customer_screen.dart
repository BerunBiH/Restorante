import 'package:cross_scroll/cross_scroll.dart';
import 'package:erestorante_desktop/models/customer.dart';
import 'package:erestorante_desktop/models/search_result.dart';
import 'package:erestorante_desktop/models/user.dart';
import 'package:erestorante_desktop/providers/customer_provider.dart';
import 'package:erestorante_desktop/providers/user_provider.dart';
import 'package:erestorante_desktop/screens/register_screen.dart';
import 'package:erestorante_desktop/screens/user_screen.dart';
import 'package:erestorante_desktop/utils/util.dart';
import 'package:erestorante_desktop/widgets/master_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomerScreen extends StatefulWidget {
  const CustomerScreen({super.key});

  @override
  State<CustomerScreen> createState() => _CustomerScreenState();
}

class _CustomerScreenState extends State<CustomerScreen> {
  final TextEditingController _searchController = TextEditingController();
  late CustomerProvider _customerProvider;
  late UserProvider _userProvider;
  SearchResult<User>? resultU;
  SearchResult<Customer>? resultC;
  bool authorised=false;
 @override
  void initState() {
    super.initState();
    super.didChangeDependencies();
    _customerProvider = context.read<CustomerProvider>();
    _userProvider = context.read<UserProvider>();
    _loadData();
  }
  Future<void> _loadData() async {
    var data = await _customerProvider.get();
    var dataU = await _userProvider.get();

    setState(() {
      resultU = dataU;
      resultC=data;
      var user=resultU!.result.firstWhere((u)=> u.userEmail!.contains(Authorization.email!));
      if(user.userRoles![0].role!.roleName!="Menedzer")
      {
        authorised=false;
      }
      else{
        authorised=true;
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return MasterScreenWidget(isJelovnikPressed: false,
    isKorisniciPressed: true,
    isMojProfilPressed: false,
    isPostavkePressed: false,
    isRecenzijePressed: false,
    isRezervacijePressed: false,
    isUposleniciPressed: false,
      child: 
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
                    TextField(
                      decoration: const InputDecoration(
                        labelText: 'Pretraga',
                        hintText: 'Pretrazite po imenu ili prezimenu.',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.search),
                      ),
                      controller: _searchController,
                      onChanged: (text) async {
                        var data = await _customerProvider.get(filter: {
                            'CustomerFTS': _searchController.text
                          });
                          setState(() {
                            resultC = data;
                          });
                      },
                    ),
                    const SizedBox(height: 20.0),
                    const Text("Pretrazite po imenu ili prezimenu."),
                  ],
                ),
          )
        )
      ),
    ],);
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
            'Ime',
            style: TextStyle(fontStyle: FontStyle.italic),
           ),
           ),
            ),
            const DataColumn(
          label: Expanded(
          child: Text(
            'Prezime',
            style: TextStyle(fontStyle: FontStyle.italic),
           ),
           ),
            ),
            const DataColumn(
          label: Expanded(
          child: Text(
            'Mail',
            style: TextStyle(fontStyle: FontStyle.italic),
           ),
           ),
            ),
            const DataColumn(
          label: Expanded(
          child: Text(
            'Telefon',
            style: TextStyle(fontStyle: FontStyle.italic),
           ),
           ),
            ),
            const DataColumn(
          label: Expanded(
          child: Text(
            'Datum registriranja',
            style: TextStyle(fontStyle: FontStyle.italic),
           ),
           ),
            ),
            const DataColumn(
          label: Expanded(
          child: Text(
            'Slika',
            style: TextStyle(fontStyle: FontStyle.italic),
           ),
           ),
            ),
             const DataColumn(
          label: Expanded(
          child: Text(
            'Izbriši',
            style: TextStyle(fontStyle: FontStyle.italic),
           ),
           ),
            )
      ], 
      rows: resultC?.result.map((Customer e)=>
        DataRow(onSelectChanged: (selected) => {
          if(selected==true)
          {
            
          }
        },
          cells: [
            DataCell(Text(e.customerName ?? "")),
            DataCell(Text(e.customerSurname ?? "")),
            DataCell(Text(e.customerEmail ?? "")),
            DataCell(Text(e.customerPhone ?? "")),
            DataCell(Text(e.customerDateRegister ?? "")),
            DataCell((e.customerImage=="") == true ? const Text("Nema slike")
            : Container( 
              width: 200,
              height: 100,
              child: imageFromBase64String(e.customerImage!),
            )
            ),
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
                                                "Da li ste sigurni da želite izbrisati korisnika?",
                                                textAlign: TextAlign.center,
                                              ),
                                              content: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Text(
                                                    "Ako želite izbrisati korisnika pritisnite dugme ${"Izbriši"} ako ne želite, pritisnite dugme ${"Odustani"}",
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
                                                        await _customerProvider.delete(e.customerId!);
                                                        showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return StatefulBuilder(
                                          builder: (context, setState) {
                                            return AlertDialog(
                                              title: Text(
                                                "Uspješno izbrisan korisnik",
                                                textAlign: TextAlign.center,
                                              ),
                                              content: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Text(
                                                    "Uspješno ste izbrisali izabranog korisnika!",
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
                                                                builder: (context) => CustomerScreen(),
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