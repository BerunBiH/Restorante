import 'dart:convert';

import 'package:erestorante_desktop/models/dish.dart';
import 'package:erestorante_desktop/models/search_result.dart';
import 'package:erestorante_desktop/models/user.dart';
import 'package:erestorante_desktop/providers/dish_provider.dart';
import 'package:erestorante_desktop/providers/reservation_provider.dart';
import 'package:erestorante_desktop/providers/user_provider.dart';
import 'package:erestorante_desktop/screens/dish_add_screen.dart';
import 'package:erestorante_desktop/screens/drinks_screen.dart';
import 'package:erestorante_desktop/screens/review_screen.dart';
import 'package:erestorante_desktop/utils/util.dart';
import 'package:erestorante_desktop/widgets/master_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DishesScreen extends StatefulWidget {
  const DishesScreen({super.key});

  @override
  State<DishesScreen> createState() => _DishesScreenState();
}

class _DishesScreenState extends State<DishesScreen> {
  final TextEditingController _searchController = TextEditingController();
  late UserProvider _userProvider;
  late DishProvider _dishProvider;
  SearchResult<User>? resultU;
  SearchResult<Dish>? resultD;
  bool authorised=false;
  bool _isLoading = true;
  bool _isHovered = false;

   @override
  void initState() {
    super.initState();
    _userProvider = context.read<UserProvider>();
    _dishProvider = context.read<DishProvider>();
    _loadData();
  }
  Future<void> _loadData() async {
    var dataU = await _userProvider.get();
    var dataD = await _dishProvider.get();

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
                    final dish = resultD!.result[index];
                    return _foodCardBuilder(dish);
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
                        hintText: 'Pretrazite po imenu jela.',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.search),
                      ),
                      controller: _searchController,
                      onChanged: (text) async {
                        var data = await _dishProvider.get(filter: {
                            'DishName': _searchController.text
                          });
                          setState(() {
                            resultD = data;
                          });
                      },
                    ),
                    const SizedBox(height: 20.0),
                    const Text("Pretrazite po nazivu jela"),
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
                    builder: (context) => DishAddScreen(),
                  ),
                );
              },
                      child: Text('Dodaj jelo'),
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
                builder: (context) => DrinksScreen(),
              ),
            );
          },
        child: Text('Pića'),
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


  Widget _foodCardBuilder(Dish dish) {
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
                child: dish.dishImage != null && dish.dishImage!.isNotEmpty
                ? Image.memory(
                    base64Decode(dish.dishImage!),
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
                      dish.dishName!,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24.0,
                        color: Colors.black,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 8),
                    Text(
                      dish.dishDescription!,
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.black,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 8),
                    Text(
                      "Cijena: ${dish.dishCost!.toString()}KM",
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
                                                "Da li ste sigurni da želite izbrisati jelo?",
                                                textAlign: TextAlign.center,
                                              ),
                                              content: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Text(
                                                    "Ako želite izbrisati jelo pritisnite dugme ${"Izbriši"} ako ne želite, pritisnite dugme ${"Odustani"}",
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
                                                        await _dishProvider.delete(dish.dishID!);
                                                        showDialog(
                                                          barrierDismissible: false,
                                      context: context,
                                      builder: (BuildContext context) {
                                        return StatefulBuilder(
                                          builder: (context, setState) {
                                            return AlertDialog(
                                              title: Text(
                                                "Uspješno izbrisano jelo",
                                                textAlign: TextAlign.center,
                                              ),
                                              content: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Text(
                                                    "Uspješno ste izbrisali jelo!",
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
                                                                builder: (context) => DishesScreen(),
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
            icon: Icon(Icons.info_outline),
            color: Colors.deepPurpleAccent,      
            onPressed: () {
              Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                builder: (context) => ReviewScreen(dish: dish,),
                                                              ),
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
                                                "Da li ste sigurni da želite urediti jelo?",
                                                textAlign: TextAlign.center,
                                              ),
                                              content: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Text(
                                                    "Ako želite urediti jelo pritisnite dugme ${"Uredu"} ako ne želite, pritisnite dugme ${"Odustani"}",
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
                                                                builder: (context) => DishAddScreen(dish: dish,),
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