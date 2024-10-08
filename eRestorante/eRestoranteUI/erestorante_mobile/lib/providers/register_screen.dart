import 'dart:convert';
import 'dart:io';

import 'package:date_only/date_only.dart';
import 'package:erestorante_mobile/main.dart';
import 'package:erestorante_mobile/models/customer.dart';
import 'package:erestorante_mobile/models/customerInsert.dart';
import 'package:erestorante_mobile/models/role.dart';
import 'package:erestorante_mobile/models/search_result.dart';
import 'package:erestorante_mobile/models/user.dart';
import 'package:erestorante_mobile/models/userInsert.dart';
import 'package:erestorante_mobile/models/userRoleInsert.dart';
import 'package:erestorante_mobile/models/userRoleUpdate.dart';
import 'package:erestorante_mobile/providers/customer_provider.dart';
import 'package:erestorante_mobile/providers/role_provider.dart';
import 'package:erestorante_mobile/providers/userRole_provider.dart';
import 'package:erestorante_mobile/providers/user_provider.dart';
import 'package:erestorante_mobile/utils/util.dart';
import 'package:erestorante_mobile/widgets/master_login_screen.dart';
// import 'package:erestorante_mobile/screens/user_screen.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatefulWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordRepeatController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _surenameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {

  bool _showPassword = false;
  bool _showRepeatPassword = false;
  Color _emailColor = Colors.black;
  Color _nameColor= Colors.black;
  Color _surenameColor= Colors.black;
  Color _phoneNumberColor= Colors.black;
  Color _passwordColor= Colors.black;
  late CustomerProvider _customerProvider;
  SearchResult<Customer>? result;
  late List<User> users;
  late List<Customer> customers;
  bool _isLoading = true;
  String? base64Image="";
  ImageProvider _profileImage = AssetImage('assets/images/RestoranteProfilePicturePlaceholder.png') as ImageProvider;

Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      final File file = File(image.path);
      final bytes = await file.readAsBytes();
      setState(() {
        base64Image = base64Encode(bytes);
        _profileImage = imageFromBase64String(base64Image!).image;  // Update cached image
      });
    }

  }

  bool validateEmail(TextEditingController controller) {
    final emailRegex = RegExp(r"[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+\.[a-zA-Z]+");
    if (controller.text.isEmpty) {
      setState(() {
        _emailColor = Colors.red; // Change color to red on empty field
      });
      return false;
    } else if (emailRegex.hasMatch(controller.text)==false) {
      setState(() {
        _emailColor = Colors.red; // Change color to red on invalid format
      });
      return false;
    }
    setState(() {
      _emailColor = Colors.black; // Reset color to black on valid input
    });
    return true; // No error
  }

  bool validateEmailExistance(TextEditingController controller)
  {
    bool mailExists=false;
    customers.forEach((customer){
      
      if(customer.customerEmail==controller.text)
        {
      mailExists=true;
      _emailColor = Colors.red;
                                          showDialog(
                                      barrierDismissible: false,
                                      context: context,
                                      builder: (BuildContext context) {
                                        return StatefulBuilder(
                                          builder: (context, setState) {
                                            return AlertDialog(
                                              title: Text(
                                                "Upss, nešto nije okay!",
                                                textAlign: TextAlign.center,
                                              ),
                                              content: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Text(
                                                    "Ovaj mail se vec koristi, pokusajte sa drugim!",
                                                    textAlign: TextAlign.center,
                                                  ),
                                                ],
                                              ),
                                              actions: [
                                                ElevatedButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: const Text("Ok"),
                                                ),
                                              ],
                                            );
                                          },
                                        );
                                      },
                                    );
    }
    });
    if(mailExists)
    {
      _emailColor = Colors.red;
      return false;
    }
    setState(() {
      _emailColor = Colors.black; // Reset color to black on valid input
    });
    return true; // No error
  }

  bool validateName(TextEditingController controller, bool isName)
  {
    if (controller.text.isEmpty && isName) {
      setState(() {
        _nameColor = Colors.red; // Change color to red on empty field
      });
      return false;
    }
    if (controller.text.isEmpty && !isName) {
      setState(() {
        _surenameColor = Colors.red; // Change color to red on empty field
      });
      return false;
    }
    if ((controller.text.length<2 || controller.text.length>50))
    {
      if (isName)
      {
        setState(() {
        _nameColor = Colors.red; // Change color to red on invalid format
      });
      }
      else
      {
        setState(() {
        _surenameColor = Colors.red; // Change color to red on invalid format
      });
      }
      return false;
    }
    if (isName)
      {
        setState(() {
        _nameColor = Colors.black; // Change color to red on invalid format
      });
      }
      else
      {
        setState(() {
        _surenameColor = Colors.black; // Change color to red on invalid format
      });
      }
    return true;
  }

  bool validatePhoneNumber(TextEditingController controller) {
    final phoneRegex = RegExp(r"^\+?[0-9]*$");

    if (controller.text.isEmpty) {
      setState(() {
        _phoneNumberColor = Colors.red; // Change color to red on empty field
      });
      return false;
    } else if (!phoneRegex.hasMatch(controller.text)) {
      setState(() {
        _phoneNumberColor = Colors.red; // Change color to red on empty field
      });
      return false;
    }
    setState(() {
        _phoneNumberColor = Colors.black; // Change color to red on empty field
      });
    return true;
  }

  bool validatePasswords(TextEditingController controller1, TextEditingController controller2)
  {
    if((controller1.text!=controller2.text)|| controller1.text.isEmpty)
    {
        setState(() {
        _passwordColor = Colors.red; // Change color to red on invalid format
      });
      return false;
    }
      setState(() {
      _passwordColor = Colors.black; // Reset color to black on valid input
    });
      return true;
  }

  @override
  void initState() {
    super.initState();
    super.didChangeDependencies();

    _customerProvider = context.read<CustomerProvider>();
    _loadData();
  }

Future<void> _loadData() async {
  var dataC = await _customerProvider.get();
  setState(() {

    result=dataC;
    customers=result!.result;

    _isLoading = false;
  });
}

  @override
  Widget build(BuildContext context) {
    return 
    (_isLoading) ?
      Center(child: CircularProgressIndicator()):
    Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Stack(
                  alignment: Alignment.center,
                  children: [
                    CircleAvatar(
                      radius: 70,
                      backgroundImage: _profileImage,
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: FloatingActionButton(
                        mini: true,
                        onPressed: () {
                          _pickImage();
                        },
                        child: Icon(Icons.camera_alt),
                      ),
                    ),
                  ],
                ),
              Container(
                  width: 400,
                  child: 
                  Card(
                    child: SingleChildScrollView(
                      padding: EdgeInsets.all(20.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Image.asset(
                            'assets/images/RestoranteLogo.png',
                            width: 450,
                            height: 100,
                          ),
                          SizedBox(height: 20.0),
                          Text(
                              'Registriraj se',
                              style: TextStyle(
                                fontSize: 30.0,
                                fontWeight: FontWeight.bold,
                                color: Color.fromRGBO(111, 63, 189, 0.612),
                              ),
                              textAlign: TextAlign.center,
                            ),
              
                          //Name text field
                          TextField(
                            controller: widget._nameController, 
                            decoration: InputDecoration(
                              labelText: 'Ime',
                              prefixIcon: Icon(Icons.info),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              errorText: _nameColor == Colors.red ? 'Ime nije ok. Ime može imati min 2 slova i max 50' : null, 
                            ),
                            keyboardType: TextInputType.name,
                            style: TextStyle(color: _nameColor), 
                            onChanged: (value) => validateName(widget._nameController,true), 
                          ),
                          SizedBox(height: 10.0),
                          //Surename text field
                          TextField(
                            controller: widget._surenameController,
                            decoration: InputDecoration(
                              labelText: 'Prezime',
                              prefixIcon: Icon(Icons.info),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              errorText: _surenameColor == Colors.red ? 'Prezime nije ok. Prezime može imati min 2 slova i max 50' : null, 
                            ),
                            keyboardType: TextInputType.name,
                            style: TextStyle(color: _surenameColor), 
                            onChanged: (value) => validateName(widget._surenameController,false), 
                          ),
                          SizedBox(height: 10.0),
                          // Email text field
                          TextField(
                            controller: widget._emailController,
                            decoration: InputDecoration(
                              labelText: 'Email',
                              prefixIcon: Icon(Icons.email),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              errorText: _emailColor == Colors.red ? 'Mail nije ok. Format mora biti: example@email.com' : null, 
                            ),
                            keyboardType: TextInputType.emailAddress,
                            style: TextStyle(color: _emailColor), 
                            onChanged: (value) => validateEmail(widget._emailController), 
                          ),
                          SizedBox(height: 10.0),
                          //Telephone text field
                          TextField(
                            controller: widget._phoneController,
                            decoration: InputDecoration(
                              labelText: 'Telefon',
                              prefixIcon: Icon(Icons.phone),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              errorText: _phoneNumberColor == Colors.red ? 'Broj telefona može samo imati brojeve' : null, 
                            ),
                            keyboardType: TextInputType.phone,
                            style: TextStyle(color: _phoneNumberColor),
                            onChanged: (value) => validatePhoneNumber(widget._phoneController), 
                          ),
                          SizedBox(height: 10.0),
                          // Password text field
                          TextField(
                            controller: widget._passwordController,
                            obscureText: !_showPassword,
                            decoration: InputDecoration(
                              labelText: 'Lozinka',
                              prefixIcon: Icon(Icons.lock),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _showPassword ? Icons.visibility : Icons.visibility_off,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _showPassword = !_showPassword;
                                  });
                                },
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            errorText: _passwordColor == Colors.red ? 'Lozinka i ponovljena lozinka moraju biti iste.' : null,
                            ),
                            style: TextStyle(color: _passwordColor),
                          ),
                          SizedBox(height: 10.0),
                          // Password Repeat text field
                          TextField(
                            controller: widget._passwordRepeatController,
                            obscureText: !_showRepeatPassword,
                            decoration: InputDecoration(
                              labelText: 'Ponovite Lozinku',
                              prefixIcon: Icon(Icons.lock),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _showRepeatPassword ? Icons.visibility : Icons.visibility_off,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _showRepeatPassword = !_showRepeatPassword;
                                  });
                                },
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              errorText: _passwordColor == Colors.red ? 'Lozinka i ponovljena lozinka moraju biti iste.' : null,
                            ),
                            style: TextStyle(color: _passwordColor),
                          ),
                          SizedBox(height: 20.0),
                          // Login button
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => LoginPage()
                                        ),
                                    );
                                },
                                child: Text('Nazad'),
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  surfaceTintColor: const Color.fromARGB(255, 255, 0, 0),
                                  overlayColor: Colors.red,
                                  padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
                                ),
                              ),
                              SizedBox(width: 50.0),
                              ElevatedButton(
                                onPressed: () async {
                                  if(!validateEmailExistance(widget._emailController))
                                  {
                                    return;
                                  }
                                  if(!validatePasswords(widget._passwordController, widget._passwordRepeatController))
                                  {
                                    return;
                                  }
                                    if((!validateName(widget._nameController,true) || !validateName(widget._surenameController,false)) || (!validateEmail(widget._emailController) ||(!validatePhoneNumber(widget._phoneController))))
                                    {
                                      return;
                                    }
                                    else
                                    {
                                        try{
                                            CustomerInsert newUser=CustomerInsert(widget._nameController.text, widget._surenameController.text, widget._emailController.text, widget._phoneController.text,widget._passwordController.text,widget._passwordRepeatController.text,base64Image);
                                            Authorization.email="admin.admin@gmail.com";
                                            Authorization.password="admin";
                                            await _customerProvider.insert(newUser);
                                            showDialog(
                                              barrierDismissible: false,
                                              context: context,
                                              builder: (BuildContext context) {
                                                return StatefulBuilder(
                                                  builder: (context, setState) {
                                                    return AlertDialog(
                                                      title: Text(
                                                        "Uspješno ste napravili račun",
                                                        textAlign: TextAlign.center,
                                                      ),
                                                      content: Column(
                                                        mainAxisSize: MainAxisSize.min,
                                                        children: [
                                                          Text(
                                                            "Uspješno ste se registrirali! Prijavite se",
                                                            textAlign: TextAlign.center,
                                                          ),
                                                          SizedBox(height: 20),
                                                        ],
                                                      ),
                                                      actions: [
                                                        ElevatedButton(
                                                          onPressed: () async {
                                                            Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                builder: (context) => LoginPage(),
                                                              ),
                                                            );
                                                          },
                                                          child: const Text("Ok"),
                                                        ),
                                                      ],
                                                    );
                                                  },
                                                );
                                              },
                                            );
                                        }
                                        on Exception catch (e) {
                                      showDialog(barrierDismissible: false,context: context, builder: (BuildContext context)=> 
                                      AlertDialog(
                                        title: Text("Greška u registraciji",textAlign: TextAlign.center,),
                                        content: Text("Upps, nešto nije okay, pokušajte ponovo!", textAlign: TextAlign.center,),
                                        actions: [
                                          ElevatedButton(onPressed: ()=> Navigator.pop(context), child: Text("OK"),)
                                        ],
                                      ));
                                      return;
                                    }
                                    }
                                },
                                child: Text('Registriraj'),
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  overlayColor: Colors.green,
                                  padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10.0),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => LoginPage()
                                        ),
                                    );
                            },
                            child: Text('Već imate račun?'),
                            style: TextButton.styleFrom(
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}