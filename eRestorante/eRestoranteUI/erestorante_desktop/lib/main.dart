import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp()); 
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: LayoutExamples(),
    );
  }
}

class AppBar extends StatelessWidget{
  String title;
  AppBar({Key? key, required this.title}) : super(key:key);

  @override
  Widget build(BuildContext context) {
    return Text(title, style: TextStyle(color: Color.fromARGB(255, 120, 166, 204),));
  }
}

class Counter extends StatefulWidget {
  const Counter({super.key});

  @override
  State<Counter> createState() => _CounterState();
}
class _CounterState extends State<Counter> {

  int _count=0;

  void _incrementCounter(){
    setState(() {
      _count++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(	"You have pushed the button $_count times"),
        ElevatedButton(onPressed: _incrementCounter, child: Text("Increment the number"),)
      ],
    );
  }
}

class LayoutExamples extends StatelessWidget {
  const LayoutExamples
({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: Color.fromARGB(255, 107, 9, 1),
          height: 500,
          child: Center(
            child: Container(
              height: 100,
              color: Color.fromARGB(255, 155, 130, 160),
              alignment: Alignment.center,
              child: AppBar(title:"Example text"),  
            ),
          )
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text("Item1"),
            Text("Item2"),
            Text("Item3"),
          ],
        )
      ],
    );
  }
}