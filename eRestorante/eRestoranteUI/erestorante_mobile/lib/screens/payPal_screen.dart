// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:webview_flutter/webview_flutter.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'PayPal Payment Integration',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: PayPalPaymentScreen(),
//     );
//   }
// }

// class PayPalPaymentScreen extends StatefulWidget {
//   @override
//   _PayPalPaymentScreenState createState() => _PayPalPaymentScreenState();
// }

// class _PayPalPaymentScreenState extends State<PayPalPaymentScreen> {
//   final String clientId = 'YOUR_SANDBOX_CLIENT_ID';
//   final String secret = 'YOUR_SANDBOX_SECRET';
//   String? accessToken;
//   String? approvalUrl;
//   String? executeUrl;

//   @override
//   void initState() {
//     super.initState();
//     _getAccessToken();
//   }

//   // Step 1: Get Access Token
//   Future<void> _getAccessToken() async {
//     final String authUrl = 'https://api.sandbox.paypal.com/v1/oauth2/token';
//     final String credentials = '$clientId:$secret';
//     final String encodedCredentials = base64Encode(utf8.encode(credentials));

//     final response = await http.post(
//       Uri.parse(authUrl),
//       headers: {
//         'Authorization': 'Basic $encodedCredentials',
//         'Content-Type': 'application/x-www-form-urlencoded',
//       },
//       body: {'grant_type': 'client_credentials'},
//     );

//     if (response.statusCode == 200) {
//       setState(() {
//         accessToken = jsonDecode(response.body)['access_token'];
//       });
//     } else {
//       print('Failed to get access token.');
//     }
//   }

//   // Step 2: Create PayPal Payment
//   Future<void> _createPayment() async {
//     if (accessToken == null) {
//       print('Access token is not available.');
//       return;
//     }

//     final String paymentUrl = 'https://api.sandbox.paypal.com/v1/payments/payment';
//     final Map<String, dynamic> paymentData = {
//       "intent": "sale",
//       "payer": {
//         "payment_method": "paypal"
//       },
//       "transactions": [
//         {
//           "amount": {
//             "total": "10.00",
//             "currency": "USD"
//           },
//           "description": "Test PayPal Payment"
//         }
//       ],
//       "redirect_urls": {
//         "return_url": "https://example.com/return",
//         "cancel_url": "https://example.com/cancel"
//       }
//     };

//     final response = await http.post(
//       Uri.parse(paymentUrl),
//       headers: {
//         'Content-Type': 'application/json',
//         'Authorization': 'Bearer $accessToken',
//       },
//       body: jsonEncode(paymentData),
//     );

//     if (response.statusCode == 201) {
//       final paymentResponse = jsonDecode(response.body);
//       setState(() {
//         approvalUrl = paymentResponse['links']
//             .firstWhere((link) => link['rel'] == 'approval_url')['href'];
//         executeUrl = paymentResponse['links']
//             .firstWhere((link) => link['rel'] == 'execute')['href'];
//       });
//       // Open WebView for user approval
//       Navigator.of(context).push(MaterialPageRoute(
//           builder: (context) => PayPalWebView(
//                 approvalUrl: approvalUrl!,
//                 onApproval: (payerId) {
//                   _executePayment(payerId);
//                 },
//               )));
//     } else {
//       print('Failed to create payment.');
//     }
//   }

//   // Step 3: Execute Payment
//   Future<void> _executePayment(String payerId) async {
//     if (executeUrl == null) {
//       print('Execute URL is not available.');
//       return;
//     }

//     final response = await http.post(
//       Uri.parse(executeUrl!),
//       headers: {
//         'Content-Type': 'application/json',
//         'Authorization': 'Bearer $accessToken',
//       },
//       body: jsonEncode({"payer_id": payerId}),
//     );

//     if (response.statusCode == 200) {
//       print('Payment executed successfully.');
//       // You can handle success here, e.g., show success screen or navigate back
//     } else {
//       print('Payment execution failed.');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('PayPal Payment'),
//       ),
//       body: Center(
//         child: ElevatedButton(
//           onPressed: _createPayment,
//           child: Text('Pay with PayPal'),
//         ),
//       ),
//     );
//   }
// }

// class PayPalWebView extends StatefulWidget {
//   final String approvalUrl;
//   final Function(String payerId) onApproval;

//   PayPalWebView({required this.approvalUrl, required this.onApproval});

//   @override
//   _PayPalWebViewState createState() => _PayPalWebViewState();
// }

// class _PayPalWebViewState extends State<PayPalWebView> {
//   late WebViewController _webViewController;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('PayPal Checkout'),
//       ),
//       body: WebViewWidget(
//         initialUrl: widget.approvalUrl,
//         javascriptMode: JavascriptMode.unrestricted,
//         onPageFinished: (String url) {
//           if (url.contains('PayerID')) {
//             final Uri uri = Uri.parse(url);
//             final payerId = uri.queryParameters['PayerID'];
//             if (payerId != null) {
//               widget.onApproval(payerId);
//               Navigator.of(context).pop();
//             }
//           }
//         },
//       ),
//     );
//   }
// }
