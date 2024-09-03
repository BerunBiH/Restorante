// import 'package:erestorante_mobile/screens/customer_screen.dart';
// import 'package:erestorante_mobile/screens/dishes_screen.dart';
import 'package:erestorante_mobile/screens/main_menu_sreen.dart';
import 'package:erestorante_mobile/screens/profile_screen.dart';
// import 'package:erestorante_mobile/screens/reservation_screen.dart';
// import 'package:erestorante_mobile/screens/review_screen.dart';
import 'package:erestorante_mobile/screens/settings_screen.dart';
// import 'package:erestorante_mobile/screens/user_screen.dart';
import 'package:erestorante_mobile/utils/util.dart';
import 'package:flutter/material.dart';
import 'package:erestorante_mobile/main.dart';

class MasterScreenWidget extends StatefulWidget {
  Widget? child;
  final bool isJelovnikPressed;
  final bool isRecenzijePressed;
  final bool isUposleniciPressed;
  final bool isRezervacijePressed;
  final bool isKorisniciPressed;
  final bool isMojProfilPressed;
  final bool isPostavkePressed;
   MasterScreenWidget({required this.isJelovnikPressed,required this.isRecenzijePressed,required this.isUposleniciPressed,required this.isRezervacijePressed,required this.isKorisniciPressed,required this.isMojProfilPressed,required this.isPostavkePressed,this.child, super.key});

  @override
  State<MasterScreenWidget> createState() => _MasterScreenWidgetState();
}

class _MasterScreenWidgetState extends State<MasterScreenWidget> {

late bool _isJelovnikPressed = widget.isJelovnikPressed;
late bool _isRecenzijePressed = widget.isRecenzijePressed;
late bool _isUposleniciPressed = widget.isUposleniciPressed;
late bool _isRezervacijePressed = widget.isRezervacijePressed;
late bool _isKorisniciPressed = widget.isKorisniciPressed;
late bool _isMojProfilPressed = widget.isMojProfilPressed;
late bool _isPostavkePressed = widget.isPostavkePressed;

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
        leading: Icon(Icons.person), 
        title: Row( 
          children: [
            Text('Moj Profil'),
          ],
        ),
        onTap: () {
          setState(() {
            _isMojProfilPressed=true;
            _isJelovnikPressed = false;
            _isRecenzijePressed = false;
            _isUposleniciPressed = false;
            _isRezervacijePressed = false;
            _isKorisniciPressed = false;
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
        leading: Icon(Icons.settings), 
        title: Row( 
          children: [
            Text('Postavke'),
          ],
        ),
        onTap: () {
          setState(() {
            _isMojProfilPressed=false;
            _isJelovnikPressed = false;
            _isRecenzijePressed = false;
            _isUposleniciPressed = false;
            _isRezervacijePressed = false;
            _isKorisniciPressed = false;
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

}