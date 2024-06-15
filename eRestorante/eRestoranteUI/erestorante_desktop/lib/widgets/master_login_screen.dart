import 'package:flutter/material.dart';

// ignore: must_be_immutable
class MasterLoginScreenWidget extends StatefulWidget {
Widget? child;
  MasterLoginScreenWidget({this.child, super.key});

  @override
  State<MasterLoginScreenWidget> createState() => __MasterLoginScreenWidgetState();
}

class __MasterLoginScreenWidgetState extends State<MasterLoginScreenWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: widget.child,),
    );
  }
}