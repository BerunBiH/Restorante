import 'package:flutter/material.dart';

class MasterLoginScreenWidget extends StatefulWidget {
Widget? child;
  MasterLoginScreenWidget({this.child, Key? key}):super (key:key);

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