import 'package:cross_scroll/cross_scroll.dart';
import 'package:erestorante_desktop/models/search_result.dart';
import 'package:erestorante_desktop/models/user.dart';
import 'package:erestorante_desktop/providers/user_provider.dart';
import 'package:erestorante_desktop/screens/register_screen.dart';
import 'package:erestorante_desktop/utils/util.dart';
import 'package:erestorante_desktop/widgets/master_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({super.key});

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  final TextEditingController _searchController = TextEditingController();
  late UserProvider _userProvider;
  SearchResult<User>? result;
  bool authorised=false;
 @override
  void initState() {
    super.initState();
    super.didChangeDependencies();
    _userProvider = context.read<UserProvider>();
    _loadData();
  }

  Future<void> _loadData() async {
    var data = await _userProvider.get();
    setState(() {
      result = data;
      var user=result!.result.firstWhere((u)=> u.userEmail!.contains(Authorization.email!));
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
    isKorisniciPressed: false,
    isMojProfilPressed: false,
    isPostavkePressed: false,
    isRecenzijePressed: false,
    isRezervacijePressed: false,
    isUposleniciPressed: true,
      child: 
      Container(
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
              Container(
        width: 400,
        height: 100,
        child: Card(
          child: SingleChildScrollView(
              padding: const EdgeInsets.all(20.0),
              child: ElevatedButton(
                        onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => RegisterScreen()
                                ),
                            );
                        },
                        child: Text('Registriraj Novog Radnika'),
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          surfaceTintColor:  Colors.green,
                          overlayColor: Colors.green,
                          padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
                        ),
              )
          )
        )
        )
            ],
          ),
      )
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
                        var data = await _userProvider.get(filter: {
                            'UserFTS': _searchController.text
                          });
                          setState(() {
                            result = data;
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
            'Uloga',
            style: TextStyle(fontStyle: FontStyle.italic),
           ),
           ),
            ),
            const DataColumn(
          label: Expanded(
          child: Text(
            'Prosječna ocjena radnika',
            style: TextStyle(fontStyle: FontStyle.italic),
           ),
           ),
            ),
            const DataColumn(
          label: Expanded(
          child: Text(
            'Komentari radnika',
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
            'Uredi',
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
      rows: result?.result.map((User e)=>
        DataRow(onSelectChanged: (selected) => {
          if(selected==true)
          {
            
          }
        },
          cells: [
            DataCell(Text(e.userName ?? "")),
            DataCell(Text(e.userSurname ?? "")),
            DataCell(Text(e.userEmail ?? "")),
            DataCell(Text(e.userPhone ?? "")),
            DataCell(
              (e.userRoles == null || e.userRoles!.isEmpty) 
                ? const Text("") 
                : Text(e.userRoles![0].role!.roleName!)
            ),
            DataCell(Text("")),
            DataCell(Text("")),
            DataCell((e.userImage=="") == true ? const Text("Nema slike")
            : Container( 
              width: 200,
              height: 100,
              child: imageFromBase64String(e.userImage!),
            )
            ),
            DataCell(
              IconButton(
            icon: Icon(Icons.edit_rounded),  
            onPressed: () {
              Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => RegisterScreen(user: e,)
                                ),
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
                                                "Da li ste sigurni da želite izbrisati radnika?",
                                                textAlign: TextAlign.center,
                                              ),
                                              content: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Text(
                                                    "Ako želite izbrisati radnika pritisnite dugme ${"Izbriši"} ako ne želite, pritisnite dugme ${"Odustani"}",
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
                                                        await _userProvider.delete(e.userId!);
                                                        showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return StatefulBuilder(
                                          builder: (context, setState) {
                                            return AlertDialog(
                                              title: Text(
                                                "Uspješno izbrisan radnik",
                                                textAlign: TextAlign.center,
                                              ),
                                              content: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Text(
                                                    "Uspješno ste izbrisali izabranog radnika!",
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
                                                                builder: (context) => UserScreen(),
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
                                                      child: const Text("Ok"),
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
                                                      onPressed: () async {
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