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
          child: Column(
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
        child: SingleChildScrollView(
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
            )
      ], 
      rows: result?.result.map((User e)=>
        DataRow(onSelectChanged: (selected) => {
          if(selected==true)
          {
            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => RegisterScreen(user: e,)
                                ),
                            )
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
            DataCell((e.userImage=="") == true ? const Text("Nema slike")
            : Container( 
              width: 200,
              height: 100,
              child: imageFromBase64String(e.userImage!),
            )
            ),
            DataCell(Icon(Icons.edit_rounded)),
          ] 
        )
      ).toList() ?? []
      ),
      )
      );
  }
}