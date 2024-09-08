// File: cancel_page.dart

import 'package:erestorante_mobile/models/orders.dart';
import 'package:erestorante_mobile/screens/order_screen.dart';
import 'package:flutter/material.dart';

class CancelPage extends StatelessWidget {
  final Order lastOrder;
  final int cartCount;

  CancelPage({super.key, required this.lastOrder, required this.cartCount});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.cancel, color: Colors.red, size: 100),
            SizedBox(height: 20),
            Text(
              "Vaše placanje je otkazano. Vratite se na pregled narudzbe",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => OrderScreen(lastOrder:lastOrder, cartCount: cartCount),
                ),
              );
              },
              child: const Text("Vrati se"),
            ),
          ],
        ),
      ),
    );
  }
}
