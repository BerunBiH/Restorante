import 'package:erestorante_desktop/providers/role_provider.dart';
import 'package:erestorante_desktop/providers/userRole_provider.dart';
import 'package:erestorante_desktop/providers/user_provider.dart';
import 'package:erestorante_desktop/screens/main_menu_sreen.dart';
import 'package:erestorante_desktop/utils/util.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => UserProvider()),
    ChangeNotifierProvider(create: (_) => RoleProvider()),
    ChangeNotifierProvider(create: (_) => UserRoleProvider())

  ],
  child: const MyApp(),
  ));
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
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  late UserProvider _userProvider;

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _showPassword = false;
  Color _emailColor = Colors.black;

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

  @override
  Widget build(BuildContext context) {
   widget._userProvider = context.read<UserProvider>();

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
                  Image.asset(
                    'assets/images/RestoranteLogo.png', 
                    width: 450,
                    height: 100,
                  ),
                  SizedBox(height: 20.0),
                  Text(
                      'Login',
                      style: TextStyle(
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold,
                        color: Color.fromRGBO(111, 63, 189, 0.612),
                      ),
                    ),
                  // Email text field
                  TextField(
                    controller: widget._emailController,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      prefixIcon: Icon(Icons.email),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      errorText: _emailColor == Colors.red ? 'Mail nije ok. Format mora biti: example@email.com' : null, // Show error text when red
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
                    ),
                  ),
                  SizedBox(height: 20.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MainMenuSreen()
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
                            if(!validateEmail(widget._emailController))
                            {
                              return;
                            }
                            Authorization.email=widget._emailController.text;
                            Authorization.password=widget._passwordController.text;

                            try{
                              await widget._userProvider.get();
                            } on Exception catch (e) {
                              showDialog(context: context, builder: (BuildContext context)=> 
                              AlertDialog(
                                title: Text("Greška u prijavi",textAlign: TextAlign.center,),
                                content: Text("Unjeli ste pogresne podatke, pokusajte opet sa ipsravnim!", textAlign: TextAlign.center,),
                                actions: [
                                  ElevatedButton(onPressed: ()=> Navigator.pop(context), child: Text("OK"),)
                                ],
                              ));
                              return;
                            }
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MainMenuSreen()
                                ),
                            );
                        },
                        child: Text('Login'),
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
