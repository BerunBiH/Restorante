// File: paypal_screen.dart

import 'dart:convert';
import 'package:erestorante_mobile/models/orders.dart';
import 'package:erestorante_mobile/screens/cancel_screen.dart';
import 'package:erestorante_mobile/screens/order_screen.dart';
import 'package:erestorante_mobile/screens/sucess_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:webview_flutter/webview_flutter.dart';
class PayPalScreen extends StatefulWidget {
  final double totalAmount;
  final Order lastOrder;
  final int cartCount;
  final bool takeOut;

  PayPalScreen({super.key, required this.totalAmount, required this.lastOrder, required this.cartCount, required this.takeOut});
  @override
  _PayPalScreenState createState() => _PayPalScreenState();
}

class _PayPalScreenState extends State<PayPalScreen> {
  bool isLoading = true;
  late final double _totalAmount;
  late final Order _lastOrder;
  late final int _cartCount;
  late final bool _takeOut;
  late WebViewController _controller;

  final String clientId = 'AY2OUScscRr96J0OgR0P9z3m9MUIDcf9rL1yQiPDWZ7Km1qctQ3wkrtuNqBhTmx0YyGLK_Hn2HFPJegr';
  final String clientSecret = 'EEX3oSKJP7U4DLIEwRSwkXFWZ4OfYOby3wIVy3D-h4X8M12YdGShgElb2K7X-MF_K97PQtBOOcTWFx34';

  final String _paypalBaseUrl = 'https://api.sandbox.paypal.com'; // Sandbox URL

  @override
  void initState() {
    super.initState();

    _totalAmount=widget.totalAmount;
    _lastOrder=widget.lastOrder;
    _cartCount=widget.cartCount;
    _takeOut=widget.takeOut;
    _startPaymentProcess();
  }

  Future<void> _startPaymentProcess() async {
    try {
      final accessToken = await _getAccessToken();
      final orderUrl = await _createOrder(accessToken, _totalAmount);
      _redirectToPayPal(orderUrl);
    } catch (e) {
      print("Error during PayPal payment process: $e");
    }
  }

  Future<String> _getAccessToken() async {
    final response = await http.post(
      Uri.parse('$_paypalBaseUrl/v1/oauth2/token'),
      headers: {
        'Authorization': 'Basic ${base64Encode(utf8.encode('$clientId:$clientSecret'))}',
        'Content-Type': 'application/x-www-form-urlencoded',
      },
      body: 'grant_type=client_credentials',
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['access_token'];
    } else {
      throw Exception('Failed to obtain PayPal access token');
    }
  }

  Future<String> _createOrder(String accessToken, double total) async {
    final response = await http.post(
      Uri.parse('$_paypalBaseUrl/v2/checkout/orders'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken',
      },
      body: jsonEncode({
        'intent': 'CAPTURE',
        'purchase_units': [
          {
            'amount': {
              'currency_code': 'EUR',
              'value': total,
            },
          },
        ],
        'application_context': {
          'return_url': 'https://your-success-url.com',
          'cancel_url': 'https://your-cancel-url.com',
        }
      }),
    );

    if (response.statusCode == 201) {
      final data = jsonDecode(response.body);
      final approvalUrl = data['links']
          .firstWhere((link) => link['rel'] == 'approve')['href'];
      return approvalUrl;
    } else {
      throw Exception('Failed to create PayPal order');
    }
  }

  void _redirectToPayPal(String approvalUrl) {
    final webviewController = _createWebViewController(approvalUrl);

    Navigator.of(context).push(MaterialPageRoute(builder: (builder) {
      return Scaffold(
        body: WebViewWidget(
          controller: webviewController,
        ),
      );
    }));
  }

  WebViewController _createWebViewController(String approvalUrl) {
    return WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (url) {
            print("Page started loading: $url");
            setState(() {
              isLoading = true;
            });
          },
          onPageFinished: (url) {
            print("Page finished loading: $url");
            setState(() {
              isLoading = false;
            });
          },
          onNavigationRequest: (request) {
            final url = request.url;

            if (url.startsWith('https://your-success-url.com')) {
              print("Payment successful");
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => SuccessPage(lastOrder: _lastOrder, takeOut: _takeOut),
                ),
              );
            }

            if (url.startsWith('https://your-cancel-url.com')) {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => CancelPage(lastOrder:_lastOrder, cartCount: _cartCount),
                ),
              );
            }

            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(approvalUrl));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => OrderScreen(lastOrder:_lastOrder, cartCount: _cartCount),
                ),
              );
              },
              child: const Text("Nazad"),
            ),
          ),
          if (isLoading)
            const Center(child: CircularProgressIndicator()),
        ],
      ),
    );
  }
}
