import 'package:erestorante_mobile/models/customer.dart';
import 'package:erestorante_mobile/models/search_result.dart';
import 'package:erestorante_mobile/models/customer.dart';
import 'package:erestorante_mobile/providers/customer_provider.dart';
import 'package:erestorante_mobile/providers/customer_provider.dart';
import 'package:erestorante_mobile/utils/util.dart';
import 'package:erestorante_mobile/widgets/master_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late CustomerProvider _customerProvider;
  bool _isLoading = true;
  late Customer customer;

@override
  void initState() {
    super.initState();

    _customerProvider = context.read<CustomerProvider>();
    _loadData();
  }

Future<void> _loadData() async {
  var data = await _customerProvider.get();
  setState(() {
    var customers=data.result;
    for(var cus in customers)
    {
      if(cus.customerId==Info.id)
      {
        customer=cus;
      }
    }
    _isLoading = false;
  });
}

  @override
  Widget build(BuildContext context) {
    return MasterScreenWidget(isJelovnikPressed: false,
    isKorpaPressed: false,
    isMojProfilPressed: true,
    isPostavkePressed: false,
    isRecenzijePressed: false,
    isRezervacijePressed: false,
    orderExists: false,
      child: 
      (_isLoading) ?
      Center(child: CircularProgressIndicator()):
      _customerPageBuilder(),
    );
  }

  Scaffold _customerPageBuilder() {
    return Scaffold(
    body: Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CircleAvatar(
              radius: 70,
               backgroundImage: Info.image !=""
                  ? imageFromBase64String(Info.image!).image
                  : AssetImage('assets/images/RestoranteProfilePicturePlaceholder.png') as ImageProvider,
            ),
            SizedBox(height: 30),
            Card(
              elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
            Container(
              padding: EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.purpleAccent),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Text(
                '${customer.customerName} ${customer.customerSurname}',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Ime i prezime',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[700],
              ),
            ),
            SizedBox(height: 20),
            Container(
              padding: EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.purpleAccent),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Text(
                Authorization.email!,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[700],
                ),
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Email',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[700],
              ),
            ),
            SizedBox(height: 20),
        
            Container(
              padding: EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.purpleAccent),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Text(
                customer.customerPhone!,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[700],
                ),
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Telefon',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[700],
              ),
            ),
            
            SizedBox(height: 20),
            ]
          )
        )
            ),
          ],
        ),
      ),
    ),
    );
  }
}