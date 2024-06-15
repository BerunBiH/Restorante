import 'package:flutter/material.dart';
import 'package:erestorante_desktop/main.dart';

class MasterScreen extends StatefulWidget {
  const MasterScreen({super.key});

  @override
  State<MasterScreen> createState() => _MasterScreenState();
}

class _MasterScreenState extends State<MasterScreen> {

bool _isJelovnikPressed = false;
bool _isRecenzijePressed = false;
bool _isUposleniciPressed = false;
bool _isRezervacijePressed = false;
bool _isKorisniciPressed = false;
bool _isMojProfilPressed = false;
bool _isPostavkePressed = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 237, 233, 240),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              child: 
              TextButton(
                  onPressed: (){
                    setState(() {
                      _isJelovnikPressed = false;
                      _isRecenzijePressed = false;
                      _isUposleniciPressed = false;
                      _isRezervacijePressed = false;
                      _isKorisniciPressed = false;
                      _isMojProfilPressed = false;
                      _isPostavkePressed = false;
                });
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
            IntrinsicHeight(
              child: Row(
              children: [
                TextButton(
                  onPressed: (){
                    setState(() {
                    _isJelovnikPressed = true;
                      _isRecenzijePressed = false;
                      _isUposleniciPressed = false;
                      _isRezervacijePressed = false;
                      _isKorisniciPressed = false;
                      _isMojProfilPressed = false;
                      _isPostavkePressed = false;
                  });
                  },
                  child: Text('Jelovnik',
                  style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                ),
                  ),
                  style: TextButton.styleFrom(
                    backgroundColor: _isJelovnikPressed ? Color.fromRGBO(111, 63, 189, 0.612) : Colors.transparent,
                  ),
                ),
                const VerticalDivider(
                  width: 10,
                  thickness: 2,
                  color: Colors.black,
                ),
                TextButton(
                  onPressed: (){
                     setState(() {
                      _isJelovnikPressed = false;
                      _isRecenzijePressed = true;
                      _isUposleniciPressed = false;
                      _isRezervacijePressed = false;
                      _isKorisniciPressed = false;
                      _isMojProfilPressed = false;
                      _isPostavkePressed = false;
                     });
                  },
                  child: Text('Recenzije',
                  style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                ),
                  ),
                  style: TextButton.styleFrom(
                    backgroundColor: _isRecenzijePressed ? Color.fromRGBO(111, 63, 189, 0.612) : Colors.transparent,
                  ),
                ),
                const VerticalDivider(
                  width: 10,
                  thickness: 2,
                  color: Colors.black,
                ),
                TextButton(
                  onPressed: (){
                     setState(() {
                    _isJelovnikPressed = false;
                    _isRecenzijePressed = false;
                    _isUposleniciPressed = true;
                    _isRezervacijePressed = false;
                    _isKorisniciPressed = false;
                    _isMojProfilPressed = false;
                    _isPostavkePressed = false;
                     });
                  },
                  child: Text('Uposlenici',
                  style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                ),
                  ),
                  style: TextButton.styleFrom(
                    backgroundColor: _isUposleniciPressed ? Color.fromRGBO(111, 63, 189, 0.612) : Colors.transparent,
                  ),
                ),
                const VerticalDivider(
                  width: 10,
                  thickness: 2,
                  color: Colors.black,
                ),
                TextButton(
                  onPressed: (){
                     setState(() {
                    _isJelovnikPressed = false;
                    _isRecenzijePressed = false;
                    _isUposleniciPressed = false;
                    _isRezervacijePressed = true;
                    _isKorisniciPressed = false;
                    _isMojProfilPressed = false;
                    _isPostavkePressed = false;
                     });
                  },
                  child: Text('Rezervacije',
                  style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                ),
                  ),
                  style: TextButton.styleFrom(
                    backgroundColor: _isRezervacijePressed ? Color.fromRGBO(111, 63, 189, 0.612) : Colors.transparent,
                  ),
                ),
                const VerticalDivider(
                  width: 10,
                  thickness: 2,
                  color: Colors.black,
                ),
                TextButton(
                  onPressed: (){
                     setState(() {
                    _isJelovnikPressed = false;
                    _isRecenzijePressed = false;
                    _isUposleniciPressed = false;
                    _isRezervacijePressed = false;
                    _isKorisniciPressed = true;
                    _isMojProfilPressed = false;
                    _isPostavkePressed = false;
                     });
                  },
                  child: Text('Korisnici',
                  style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                ),
                  ),
                  style: TextButton.styleFrom(
                    backgroundColor: _isKorisniciPressed ? Color.fromRGBO(111, 63, 189, 0.612) : Colors.transparent,
                  ),
                ),
              ],
            ),
            ),
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
                  backgroundImage: AssetImage('assets/images/RestoranteProfilePicturePlaceholder.png'),
                ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                "Name ",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24.0,
                ),
              ),
              Text(
                "Surename",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24.0,
                ),
              ),
              ],
            ),
              Text(
                "email@mail.com",
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
    );
  }
}