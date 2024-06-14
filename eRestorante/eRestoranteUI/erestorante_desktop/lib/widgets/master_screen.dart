import 'dart:async';

import 'package:flutter/material.dart';

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
          // Remove padding
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Color.fromRGBO(111, 63, 189, 0.612),
              ),
              child: Text(
                'Ime Prezime',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              title: Text('Jelovnik'),
              onTap: () {
                // Handle tap
              },
            ),
            ListTile(
              title: Text('Rezervacija'),
              onTap: () {
                // Handle tap
              },
            ),
            ListTile(
              title: Text('Moj Profil'),
              onTap: () {
                // Handle tap
              },
            ),
            ListTile(
              title: Text('Recenzije'),
              onTap: () {
                // Handle tap
              },
            ),
            ListTile(
              title: Text('Postavke'),
              onTap: () {
                // Handle tap
              },
            ),
          ],
        ),
      ),
    );
  }
}