import 'package:erestorante_desktop/widgets/master_screen.dart';
import 'package:flutter/material.dart';

class MainMenuSreen extends StatefulWidget {
  const MainMenuSreen({super.key});

  @override
  State<MainMenuSreen> createState() => _MainMenuSreenState();
}

class _MainMenuSreenState extends State<MainMenuSreen> {
  @override
  Widget build(BuildContext context) {
    return MasterScreenWidget(isJelovnikPressed: false,
    isKorisniciPressed: false,
    isMojProfilPressed: false,
    isPostavkePressed: false,
    isRecenzijePressed: false,
    isRezervacijePressed: false,
    isUposleniciPressed: false,
      child: Container(
        child: Text("Hello, this is the Main menu screen"),
      ),
    );
  }
}