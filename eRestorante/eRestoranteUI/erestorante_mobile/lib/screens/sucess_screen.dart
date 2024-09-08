// File: success_page.dart

import 'package:erestorante_mobile/models/orderUpdate.dart';
import 'package:erestorante_mobile/models/orders.dart';
import 'package:erestorante_mobile/providers/order_provider.dart';
import 'package:erestorante_mobile/screens/archive_order_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SuccessPage extends StatefulWidget {
  final Order lastOrder;
  final bool takeOut;

  SuccessPage({super.key, required this.lastOrder, required this.takeOut});
  @override
  State<SuccessPage> createState() => _SuccessPageState();
}

class _SuccessPageState extends State<SuccessPage> {
  late OrderProvider _orderProvider;
  late final Order _lastOrder;
  late final bool _takeOut;

  @override
  void initState(){
    super.initState();
    _lastOrder=widget.lastOrder;
    _takeOut=widget.takeOut;
    _orderProvider = context.read<OrderProvider>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.check_circle, color: Colors.green, size: 100),
            SizedBox(height: 20),
            Text(
              "Uspjesno ste platili!",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                if(_takeOut)
                {
                  OrderUpdate orderUpdate = OrderUpdate(1, 1);
                  await _orderProvider.update(_lastOrder.ordersId!, orderUpdate);
                }
                else
                {
                  OrderUpdate orderUpdate = OrderUpdate(0, 1);
                  await _orderProvider.update(_lastOrder.ordersId!, orderUpdate);
                }
                Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => ArchiveOrderScreen(),
                ),
              );
              },
              child: const Text("Pregled narudzbi"),
            ),
          ],
        ),
      ),
    );
  }
}
