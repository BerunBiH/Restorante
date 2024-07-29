import 'package:erestorante_desktop/main.dart';
import 'package:erestorante_desktop/widgets/master_login_screen.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordRepeatController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _surenameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

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
    return MasterLoginScreenWidget(
      child: Container(
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
                        onPressed: () {
                            if((!validateName(widget._nameController,true) || !validateName(widget._surenameController,false)) || (!validateEmail(widget._emailController) || validatePasswords(widget._passwordController, widget._passwordRepeatController)))
                            {
                              return;
                            }
                            print(widget._emailController.text);
                            print(widget._passwordController.text);
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
                  // Forgot password text
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
    );
  }
}