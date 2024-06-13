import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  // Text field controllers for email and password
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _showPassword = false;
  Color _emailColor = Colors.black;

  bool validateEmail(TextEditingController controller) {
    // Email validator regex pattern (you can customize this)
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: 400,
          child: Card(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  // App logo (replace with your logo image)
                  Image.asset(
                    'assets/images/RestoranteLogo.png', // Replace with your logo path
                    width: 450,
                    height: 200,
                  ),
                  SizedBox(height: 20.0),
                  // Email text field
                  TextField(
                    controller: widget._emailController,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      prefixIcon: Icon(Icons.email),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      errorText: _emailColor == Colors.red ? 'Invalid Email. Format needs to be: example@email.com' : null, // Show error text when red
                    ),
                    keyboardType: TextInputType.emailAddress,
                    style: TextStyle(color: _emailColor), // Set text color based on validation
                    onChanged: (value) => validateEmail(widget._emailController), // Validate on change
                  ),
                  SizedBox(height: 10.0),
                  // Password text field
                  TextField(
                    controller: widget._passwordController,
                    obscureText: !_showPassword,
                    decoration: InputDecoration(
                      labelText: 'Password',
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
                    ),
                  ),
                  SizedBox(height: 20.0),
                  // Login button
                  ElevatedButton(
                    onPressed: () {
                        if(!validateEmail(widget._emailController))
                        {
                          return;
                        }
                        print("Everything was okay");
                    },
                    child: Text('Login'),
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
                    ),
                  ),
                  SizedBox(height: 10.0),
                  // Forgot password text
                  TextButton(
                    onPressed: () {
                      // Handle forgot password logic
                      print('Forgot Password Pressed');
                    },
                    child: Text('Forgot Password?'),
                    style: TextButton.styleFrom(
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
