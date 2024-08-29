import 'dart:convert';


import 'package:erestorante_desktop/models/drink.dart';
import 'package:erestorante_desktop/models/search_result.dart';
import 'package:erestorante_desktop/models/user.dart';
import 'package:erestorante_desktop/providers/drink_provider.dart';
import 'package:erestorante_desktop/providers/user_provider.dart';
import 'package:erestorante_desktop/screens/dishes_screen.dart';
import 'package:erestorante_desktop/screens/drink_add_screen.dart';
import 'package:erestorante_desktop/utils/util.dart';
import 'package:erestorante_desktop/widgets/master_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DrinksScreen extends StatefulWidget {
  const DrinksScreen({super.key});

  @override
  State<DrinksScreen> createState() => _DrinksScreenState();
}

class _DrinksScreenState extends State<DrinksScreen> {
  final TextEditingController _searchController = TextEditingController();
  late UserProvider _userProvider;
  late DrinkProvider _drinkProvider;
  SearchResult<User>? resultU;
  SearchResult<Drink>? resultD;
  bool authorised=false;
  bool _isLoading = true;
  bool _isHovered = false;

   @override
  void initState() {
    super.initState();
    _userProvider = context.read<UserProvider>();
    _drinkProvider = context.read<DrinkProvider>();
    _loadData();
  }
  Future<void> _loadData() async {
    var dataU = await _userProvider.get();
    var dataD = await _drinkProvider.get();

    setState(() {
      resultU = dataU;
      resultD = dataD;
      var user=resultU!.result.firstWhere((u)=> u.userEmail!.contains(Authorization.email!));
      if(user.userRoles![0].role!.roleName!="Menedzer" || user.userRoles![0].role!.roleName!="Kuhar")
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
    return MasterScreenWidget(isJelovnikPressed: true,
    isKorisniciPressed: false,
    isMojProfilPressed: false,
    isPostavkePressed: false,
    isRecenzijePressed: false,
    isRezervacijePressed: false,
    isUposleniciPressed: false,
      child: 
      (_isLoading) ?
      Center(child: CircularProgressIndicator()):
      Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildSearch(),
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  crossAxisSpacing: 16.0,
                  mainAxisSpacing: 16.0,
                  childAspectRatio: 3 / 2,
                ),
                itemCount: resultD!.result.length,
                itemBuilder: (context, index) {
                  if (resultD != null && index < resultD!.result.length) {
                    final drink = resultD!.result[index];
                    return _foodCardBuilder(drink);
                  } else {
                    return SizedBox.shrink();
                   }
                 } 
              ),
            ),
          ],
        ),
      ),
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
                        hintText: 'Pretrazite po imenu pića.',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.search),
                      ),
                      controller: _searchController,
                      onChanged: (text) async {
                        var data = await _drinkProvider.get(filter: {
                            'DrinkName': _searchController.text
                          });
                          setState(() {
                            resultD = data;
                          });
                      },
                    ),
                    const SizedBox(height: 20.0),
                    const Text("Pretrazite po nazivu pića"),
   const SizedBox(height: 20.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ElevatedButton(
                      onPressed: () async {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DrinkAddScreen(),
                  ),
                );
              },
                      child: Text('Dodaj piće'),
                      style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              overlayColor: Colors.green,
              padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
                      ),
                    ),
                    const SizedBox(width: 20.0),
              ElevatedButton(
        onPressed: () async {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DishesScreen(),
              ),
            );
          },
        child: Text('Jela'),
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
    const SizedBox(height: 5.0),
  ],
),
          )
        )
      ),
    ],
    );
  }


  Widget _foodCardBuilder(Drink drink) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: Card(
        elevation: 4.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12.0),
              child: AnimatedOpacity(
                opacity: _isHovered ? 0.2 : 1.0,
                duration: Duration(milliseconds: 300),
                child: drink.drinkImage != null && drink.drinkImage!.isNotEmpty
                ? Image.memory(
                    base64Decode(drink.drinkImage!),
                    width: double.infinity,
                    height: double.infinity,
                    fit: BoxFit.cover,
                  )
                : Image.asset(
                    'assets/images/RestoranteLogo.png',
                    width: double.infinity,
                    height: double.infinity,
                    fit: BoxFit.cover,
                  ),
              ),
            ),
            Center(
              child: AnimatedOpacity(
                opacity: _isHovered ? 1.0 : 0.0,
                duration: Duration(milliseconds: 300),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      drink.drinkName!,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24.0,
                        color: Colors.black,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 8),
                    Text(
                      drink.drinkDescription!,
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.black,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 8),
                    Text(
                      "Postotak alkohola: ${drink.drinkAlcoholPerc!}%",
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.black,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 8),
                    Text(
                      "Cijena: ${drink.drinkCost!.toString()}KM",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0,
                        color: Colors.black,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 8,
              left: 8,
              right: 8,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                                              IconButton(
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
                                                "Da li ste sigurni da želite izbrisati piće?",
                                                textAlign: TextAlign.center,
                                              ),
                                              content: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Text(
                                                    "Ako želite izbrisati piće pritisnite dugme ${"Izbriši"} ako ne želite, pritisnite dugme ${"Odustani"}",
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
                                                        await _drinkProvider.delete(drink.drinkId!);
                                                        showDialog(
                                                          barrierDismissible: false,
                                      context: context,
                                      builder: (BuildContext context) {
                                        return StatefulBuilder(
                                          builder: (context, setState) {
                                            return AlertDialog(
                                              title: Text(
                                                "Uspješno izbrisano piće",
                                                textAlign: TextAlign.center,
                                              ),
                                              content: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Text(
                                                    "Uspješno ste izbrisali piće!",
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
                                                                builder: (context) => DrinksScreen(),
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
          ),
              IconButton(
            icon: Icon(Icons.edit_rounded),   
            onPressed: () {
             showDialog(
              barrierDismissible: false,
                                      context: context,
                                      builder: (BuildContext context) {
                                        return StatefulBuilder(
                                          builder: (context, setState) {
                                            return AlertDialog(
                                              title: Text(
                                                "Da li ste sigurni da želite urediti piće?",
                                                textAlign: TextAlign.center,
                                              ),
                                              content: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Text(
                                                    "Ako želite urediti piće pritisnite dugme ${"Uredu"} ako ne želite, pritisnite dugme ${"Odustani"}",
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
                                                      onPressed: () {
                                                        Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                builder: (context) => DrinkAddScreen(drink: drink,),
                                                              ),
                                                            );
                                                    },
                                                      child: const Text("Uredi"),
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
          ),
            
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}