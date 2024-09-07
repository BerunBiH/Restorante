import 'dart:convert';
import 'dart:io';

import 'package:erestorante_mobile/models/customerUpdate.dart';
import 'package:erestorante_mobile/models/search_result.dart';
import 'package:erestorante_mobile/models/customer.dart';
import 'package:erestorante_mobile/providers/customer_provider.dart';
import 'package:erestorante_mobile/providers/customer_provider.dart';
import 'package:erestorante_mobile/screens/profile_screen.dart';
import 'package:erestorante_mobile/utils/util.dart';
import 'package:erestorante_mobile/widgets/master_screen.dart';
// import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatefulWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordRepeatController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _surenameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _showPassword = false;
  bool _showRepeatPassword = false;
  Color _emailColor = Colors.black;
  Color _nameColor= Colors.black;
  Color _surenameColor= Colors.black;
  Color _phoneNumberColor= Colors.black;
  Color _passwordColor= Colors.black;
  late CustomerProvider _customerProvider;
  bool _isLoading = true;
  late Customer customer;
  String? base64Image;
  SearchResult<Customer>? resultU;
  late List<Customer> customers;
  late ImageProvider _profileImage;

  @override
  void initState() {
    super.initState();
    _customerProvider = context.read<CustomerProvider>();
    _loadData().then((_) {
      _profileImage = (Info.image != "" && base64Image == null)
          ? imageFromBase64String(Info.image!).image
          : AssetImage('assets/images/RestoranteProfilePicturePlaceholder.png') as ImageProvider;
    });
  }

  Future<void> _loadData() async {
    var dataU = await _customerProvider.get();
    setState(() {
      resultU = dataU;
      customers = resultU!.result;
      customer = customers.firstWhere((x) => x.customerId == Info.id);
      _isLoading = false;
    });
  }
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
    if (customers.isEmpty) {
      return false;
    }
    customers.removeWhere((customerNow)=> customerNow.customerEmail == customer.customerEmail);
    bool mailExists=false;
    for (var customerNow in customers) {
      if(customerNow.customerEmail==controller.text)
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
    }
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
  Widget build(BuildContext context) {
    return MasterScreenWidget(isJelovnikPressed: false,
    isKorpaPressed: false,
    isMojProfilPressed: false,
    isPostavkePressed: true,
    isRecenzijePressed: false,
    isRezervacijePressed: false,
    orderExists: false,
      child: (_isLoading) ?
      Center(child: CircularProgressIndicator()):
       _settingsPageBuilder(),
      );
  }
  
Scaffold _settingsPageBuilder() {
  return Scaffold(
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
            SizedBox(height: 30),
            Container(
              width: 400,
              child: Card(
                child: SingleChildScrollView(
                  padding: EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Postavke za ${customer.customerName}',
                        style: TextStyle(
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold,
                          color: Color.fromRGBO(111, 63, 189, 0.612),
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 10.0),
                      _buildTextField(
                        controller: widget._nameController,
                        labelText: 'Ime',
                        icon: Icons.info,
                        color: _nameColor,
                        onChanged: (value) => validateName(widget._nameController, true),
                        errorText: _nameColor == Colors.red
                            ? 'Ime nije ok. Ime može imati min 2 slova i max 50'
                            : null,
                      ),
                      SizedBox(height: 5.0),
                      Text(
                        "Ime je bilo: ${customer.customerName}"
                      ),
                      SizedBox(height: 10.0),
                      _buildTextField(
                        controller: widget._surenameController,
                        labelText: 'Prezime',
                        icon: Icons.info,
                        color: _surenameColor,
                        onChanged: (value) => validateName(widget._surenameController, false),
                        errorText: _surenameColor == Colors.red
                            ? 'Prezime nije ok. Prezime može imati min 2 slova i max 50'
                            : null,
                      ),
                      SizedBox(height: 5.0),
                      Text(
                        "Prezime je bilo: ${customer.customerSurname}"
                      ),
                      SizedBox(height: 10.0),
                      _buildTextField(
                        controller: widget._emailController,
                        labelText: 'Email',
                        icon: Icons.email,
                        color: _emailColor,
                        onChanged: (value) => validateEmail(widget._emailController),
                        errorText: _emailColor == Colors.red
                            ? 'Mail nije ok. Format mora biti: example@email.com'
                            : null,
                      ),
                      SizedBox(height: 5.0),
                      Text(
                        "Mail je bio: ${customer.customerEmail}"
                      ),
                      SizedBox(height: 10.0),
                      _buildTextField(
                        controller: widget._phoneController,
                        labelText: 'Telefon',
                        icon: Icons.phone,
                        color: _phoneNumberColor,
                        onChanged: (value) => validatePhoneNumber(widget._phoneController),
                        errorText: _phoneNumberColor == Colors.red
                            ? 'Broj telefona može samo imati brojeve'
                            : null,
                      ),
                      SizedBox(height: 5.0),
                      Text(
                        "Telefon je bio: ${customer.customerPhone}"
                      ),
                      SizedBox(height: 10.0),
                      _buildPasswordTextField(
                        controller: widget._passwordController,
                        labelText: 'Lozinka',
                        obscureText: !_showPassword,
                        onVisibilityPressed: () {
                          setState(() {
                            _showPassword = !_showPassword;
                          });
                        },
                        color: _passwordColor,
                        errorText: _passwordColor == Colors.red
                            ? 'Lozinka i ponovljena lozinka moraju biti iste.'
                            : null,
                      ),
                      SizedBox(height: 10.0),
                      _buildPasswordTextField(
                        controller: widget._passwordRepeatController,
                        labelText: 'Ponovite Lozinku',
                        obscureText: !_showRepeatPassword,
                        onVisibilityPressed: () {
                          setState(() {
                            _showRepeatPassword = !_showRepeatPassword;
                          });
                        },
                        color: _passwordColor,
                        errorText: _passwordColor == Colors.red
                            ? 'Lozinka i ponovljena lozinka moraju biti iste.'
                            : null,
                      ),
                      SizedBox(height: 20.0),
                      _buildButtonRow(),
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

Widget _buildTextField({
  required TextEditingController controller,
  required String labelText,
  required IconData icon,
  required Color color,
  required Function(String) onChanged,
  String? errorText,
}) {
  return TextField(
    controller: controller,
    decoration: InputDecoration(
      labelText: labelText,
      prefixIcon: Icon(icon),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      errorText: errorText,
    ),
    style: TextStyle(color: color),
    onChanged: onChanged,
  );
}

Widget _buildPasswordTextField({
  required TextEditingController controller,
  required String labelText,
  required bool obscureText,
  required VoidCallback onVisibilityPressed,
  required Color color,
  String? errorText,
}) {
  return TextField(
    controller: controller,
    obscureText: obscureText,
    decoration: InputDecoration(
      labelText: labelText,
      prefixIcon: Icon(Icons.lock),
      suffixIcon: IconButton(
        icon: Icon(obscureText ? Icons.visibility : Icons.visibility_off),
        onPressed: onVisibilityPressed,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      errorText: errorText,
    ),
    style: TextStyle(color: color),
  );
}

Widget _buildButtonRow() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SettingsScreen(),
            ),
          );
        },
        child: Text('Poništi promjene'),
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
          if(!validatePasswords(widget._passwordController, widget._passwordRepeatController))
          {
            return;
          }
          if((!validateName(widget._nameController,true) || !validateName(widget._surenameController,false)) || (!validateEmail(widget._emailController) ||(!validatePhoneNumber(widget._phoneController))) || !validateEmailExistance(widget._emailController))
          {
            return;
          }
          CustomerUpdate newCustomer;
          if(base64Image==null)
          {
            newCustomer=CustomerUpdate(widget._nameController.text, widget._surenameController.text, widget._emailController.text, widget._phoneController.text, widget._passwordController.text, widget._passwordRepeatController.text, customer.customerImage!);
          }
          else
          {
            newCustomer=CustomerUpdate(widget._nameController.text, widget._surenameController.text, widget._emailController.text, widget._phoneController.text, widget._passwordController.text, widget._passwordRepeatController.text, base64Image);
          }
          await _customerProvider.update(customer.customerId!,newCustomer);
          Authorization.email=newCustomer.customerEmail;
           showDialog(
            barrierDismissible: false,
                                      context: context,
                                      builder: (BuildContext context) {
                                        return StatefulBuilder(
                                          builder: (context, setState) {
                                            return AlertDialog(
                                              title: Text(
                                                "Uspješno ažurirani podaci",
                                                textAlign: TextAlign.center,
                                              ),
                                              content: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Text(
                                                    "Uspješno ste ažurirali svoje podatke!",
                                                    textAlign: TextAlign.center,
                                                  ),
                                                  SizedBox(height: 20),
                                               ],
                                              ),
                                              actions: [
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                  children: [
                                                    ElevatedButton(
                                                      onPressed: () async {
                                                        Info.image=newCustomer.customerImage;
                                                        Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                            builder: (context) => ProfileScreen(),
                                                          ),
                                                        );
                                                      },
                                                      child: const Text("Ok"),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            );
                                          },
                                        );
                                      },
                                    );
        },
        child: Text('Sačuvaj'),
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          overlayColor: Colors.green,
          padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
        ),
      ),
    ],
  );
}
}