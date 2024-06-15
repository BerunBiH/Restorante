import 'package:erestorante_desktop/widgets/master_screen.dart';
import 'package:flutter/material.dart';

class ReviewScreen extends StatefulWidget {
  const ReviewScreen({super.key});

  @override
  State<ReviewScreen> createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen> {
  @override
  Widget build(BuildContext context) {
    return MasterScreenWidget(isJelovnikPressed: false,
    isKorisniciPressed: false,
    isMojProfilPressed: false,
    isPostavkePressed: false,
    isRecenzijePressed: true,
    isRezervacijePressed: false,
    isUposleniciPressed: false,
      child: Container(
        child: Text("Hello, this is the review screen"),
      ),
    );
  }
}