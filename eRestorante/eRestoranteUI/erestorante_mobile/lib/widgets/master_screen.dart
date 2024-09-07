// import 'package:erestorante_mobile/screens/customer_screen.dart';
// import 'package:erestorante_mobile/screens/dishes_screen.dart';
import 'package:erestorante_mobile/models/orders.dart';
import 'package:erestorante_mobile/providers/order_provider.dart';
import 'package:erestorante_mobile/screens/archive_order_screen.dart';
import 'package:erestorante_mobile/screens/dishes_screen.dart';
import 'package:erestorante_mobile/screens/main_menu_sreen.dart';
import 'package:erestorante_mobile/screens/profile_screen.dart';
import 'package:erestorante_mobile/screens/reservation_screen.dart';
import 'package:erestorante_mobile/screens/review_screen.dart';
// import 'package:erestorante_mobile/screens/reservation_screen.dart';
// import 'package:erestorante_mobile/screens/review_screen.dart';
import 'package:erestorante_mobile/screens/settings_screen.dart';
// import 'package:erestorante_mobile/screens/user_screen.dart';
import 'package:erestorante_mobile/utils/util.dart';
import 'package:flutter/material.dart';
import 'package:erestorante_mobile/main.dart';
import 'package:provider/provider.dart';

class MasterScreenWidget extends StatefulWidget {
  Widget? child;
  final bool isJelovnikPressed;
  final bool isRecenzijePressed;
  final bool isKorpaPressed;
  final bool isRezervacijePressed;
  final bool isMojProfilPressed;
  final bool isPostavkePressed;
  bool? orderExists;
  int? activeOrderId;
   MasterScreenWidget({required this.isJelovnikPressed,required this.isRecenzijePressed,required this.isKorpaPressed,required this.isRezervacijePressed,required this.isMojProfilPressed,required this.isPostavkePressed,this.child, super.key, this.orderExists, this.activeOrderId});

  @override
  State<MasterScreenWidget> createState() => _MasterScreenWidgetState();
}

class _MasterScreenWidgetState extends State<MasterScreenWidget> {

late bool _isJelovnikPressed = widget.isJelovnikPressed;
late bool _isRecenzijePressed = widget.isRecenzijePressed;
late bool _isKorpaPressed = widget.isKorpaPressed;
late bool _isRezervacijePressed = widget.isRezervacijePressed;
late bool _isMojProfilPressed = widget.isMojProfilPressed;
late bool _isPostavkePressed = widget.isPostavkePressed;
late OrderProvider _orderProvider;

 @override
  void initState() {
    super.initState();
    _orderProvider = context.read<OrderProvider>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 237, 233, 240),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
GestureDetector(
              child: 
              TextButton(
                  onPressed: () async {
                     if (widget.orderExists!) {
                      bool shouldProceed = await _showDecisionDialog();

                      if (!shouldProceed) {
                        return;
                      }
                    }
                    setState(() {
                      _isJelovnikPressed = false;
                      _isRecenzijePressed = false;
                      _isKorpaPressed = false;
                      _isRezervacijePressed = false;
                      _isMojProfilPressed = false;
                      _isPostavkePressed = false;
                });
                      Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MainMenuSreen()
                                ),
                            );
                  },
                  child: Text(
                '@Restorante',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 20,
                ),
              ),
                ),
            ),
              ],
              
            ),
          ],
        ),
      ),
      drawer: Drawer(
  child: ListView(
    padding: EdgeInsets.zero,
    children: [
      DrawerHeader(
        decoration: BoxDecoration(
          color: Color.fromRGBO(111, 63, 189, 0.612),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 50.0,
                  backgroundImage: Info.image !=""
                  ? imageFromBase64String(Info.image!).image
                  : AssetImage('assets/images/RestoranteProfilePicturePlaceholder.png') as ImageProvider,
                ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("${Info.name!} ",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24.0,
                ),
              ),
              Text(
                Info.surname!,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24.0,
                ),
              ),
              ],
            ),
              Text(
                Authorization.email!,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.0,
                ),
              ),
          ],
        ),
      ),
      ListTile(
        leading: Icon(Icons.restaurant_menu_outlined), 
        title: Row( 
          children: [
            Text('Jelovnik'),
          ],
        ),
        onTap: () async {
          if (widget.orderExists!) {
            bool shouldProceed = await _showDecisionDialog();

            if (!shouldProceed) {
              return;
            }
          }
          setState(() {
            _isMojProfilPressed=false;
            _isJelovnikPressed = true;
            _isRecenzijePressed = false;
            _isKorpaPressed = false;
            _isRezervacijePressed = false;
            _isPostavkePressed = false;
          });
          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DishesScreen()
                                ),
                            );
        },
        selectedColor: Colors.white,
        selectedTileColor: Color.fromRGBO(111, 63, 189, 0.281),
        selected: _isJelovnikPressed,
      ),
      ListTile(
        leading: Icon(Icons.assignment_outlined), 
        title: Row( 
          children: [
            Text('Rezervacije'),
          ],
        ),
        onTap: () async {
          if (widget.orderExists!) {
            bool shouldProceed = await _showDecisionDialog();

            if (!shouldProceed) {
              return;
            }
          }
          setState(() {
            _isMojProfilPressed=false;
            _isJelovnikPressed = false;
            _isRecenzijePressed = false;
            _isKorpaPressed = false;
            _isRezervacijePressed = true;
            _isPostavkePressed = false;
          });
          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ReservationScreen()
                                ),
                            );
        },
        selectedColor: Colors.white,
        selectedTileColor: Color.fromRGBO(111, 63, 189, 0.281),
        selected: _isRezervacijePressed,
      ),
      ListTile(
        leading: Icon(Icons.person), 
        title: Row( 
          children: [
            Text('Moj Profil'),
          ],
        ),
        onTap: () async {
          if (widget.orderExists!) {
            bool shouldProceed = await _showDecisionDialog();

            if (!shouldProceed) {
              return;
            }
          }
          setState(() {
            _isMojProfilPressed=true;
            _isJelovnikPressed = false;
            _isRecenzijePressed = false;
            _isKorpaPressed = false;
            _isRezervacijePressed = false;
            _isPostavkePressed = false;
          });
          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ProfileScreen()
                                ),
                            );
        },
        selectedColor: Colors.white,
        selectedTileColor: Color.fromRGBO(111, 63, 189, 0.281),
        selected: _isMojProfilPressed,
      ),
      ListTile(
        leading: Icon(Icons.heart_broken_sharp), 
        title: Row( 
          children: [
            Text('Recenzije'),
          ],
        ),
        onTap: () async {
          if (widget.orderExists!) {
            bool shouldProceed = await _showDecisionDialog();

            if (!shouldProceed) {
              return;
            }
          }
          setState(() {
            _isMojProfilPressed=false;
            _isJelovnikPressed = false;
            _isRecenzijePressed = true;
            _isKorpaPressed = false;
            _isRezervacijePressed = false;
            _isPostavkePressed = false;
          });
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ReviewScreen()
              ),
          );
        },
        selectedColor: Colors.white,
        selectedTileColor: Color.fromRGBO(111, 63, 189, 0.281),
        selected: _isRecenzijePressed,
      ),
      ListTile(
        leading: Icon(Icons.shopping_basket), 
        title: Row( 
          children: [
            Text('Arhiva Korpe'),
          ],
        ),
        onTap: () async {
          if (widget.orderExists!) {
            bool shouldProceed = await _showDecisionDialog();

            if (!shouldProceed) {
              return;
            }
          }
          setState(() {
            _isMojProfilPressed=false;
            _isJelovnikPressed = false;
            _isRecenzijePressed = false;
            _isKorpaPressed = true;
            _isRezervacijePressed = false;
            _isPostavkePressed = false;
          });
          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ArchiveOrderScreen()
                                ),
                            );
        },
        selectedColor: Colors.white,
        selectedTileColor: Color.fromRGBO(111, 63, 189, 0.281),
        selected: _isKorpaPressed,
      ),
      ListTile(
        leading: Icon(Icons.settings), 
        title: Row( 
          children: [
            Text('Postavke'),
          ],
        ),
        onTap: () async {
          if (widget.orderExists!) {
            bool shouldProceed = await _showDecisionDialog();

            if (!shouldProceed) {
              return;
            }
          }
          setState(() {
            _isMojProfilPressed=false;
            _isJelovnikPressed = false;
            _isRecenzijePressed = false;
            _isRezervacijePressed = false;
            _isKorpaPressed = false;
            _isPostavkePressed = true;
          });
          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SettingsScreen()
                                ),
                            );
        },
        selectedColor: Colors.white,
        selectedTileColor: Color.fromRGBO(111, 63, 189, 0.281),
        selected: _isPostavkePressed,
      ),
      ListTile(
        leading: Icon(Icons.logout), 
        title: Row( 
          children: [
            Text('Odjava'),
          ],
        ),
        onTap: () {
          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => LoginPage()
                                ),
                            );
        },
      ),
    ],
  ),
),
body: widget.child,
    );
  }
 Future<bool> _showDecisionDialog() async {
  return await showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text("Napustate narudzbu!"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Da li ste sigurni da zelite da odete? Ako ne potvrdite narudzbu u korpi morate opet birati artikle.",
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
          ],
        ),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context, false);
                },
                child: const Text("Ostani"),
              ),
              SizedBox(width: 20.0,),
              ElevatedButton(
                onPressed: () {
                  _orderProvider.delete(widget.activeOrderId!);
                  Navigator.pop(context, true);
                },
                child: const Text("Napusti"),
              ),
            ],
          ),
        ],
      );
    },
  );
 }
}