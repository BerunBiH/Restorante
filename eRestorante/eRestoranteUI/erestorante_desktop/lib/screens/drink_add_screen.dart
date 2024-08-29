import 'dart:convert';
import 'dart:io';

import 'package:erestorante_desktop/models/categoryC.dart';
import 'package:erestorante_desktop/models/drink.dart';
import 'package:erestorante_desktop/models/drinkInsert.dart';
import 'package:erestorante_desktop/models/drinkUpdate.dart';
import 'package:erestorante_desktop/models/search_result.dart';
import 'package:erestorante_desktop/models/user.dart';
import 'package:erestorante_desktop/providers/category_provider.dart';
import 'package:erestorante_desktop/providers/drink_provider.dart';
import 'package:erestorante_desktop/screens/drinks_screen.dart';
import 'package:erestorante_desktop/utils/util.dart';
import 'package:erestorante_desktop/widgets/master_screen.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class DrinkAddScreen extends StatefulWidget {
  Drink? drink;
  final TextEditingController _costController = TextEditingController();
  final TextEditingController _alcoholController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  DrinkAddScreen({super.key, this.drink});

  @override
  State<DrinkAddScreen> createState() => _DrinkAddScreenState();
}

class _DrinkAddScreenState extends State<DrinkAddScreen> {

  Color _costColor = Colors.black;
  Color _alcoholColor = Colors.black;
  Color _nameColor= Colors.black;
  Color _descriptionColor= Colors.black;
  late DrinkProvider _drinkProvider;
  bool _isLoading = true;
  late User user;
  String? base64Image;
  String? selectedCategory;
  SearchResult<CategoryC>? result;
  late List<CategoryC> category;
  late CategoryProvider _categoryProvider;

  @override
  void initState() {
    super.initState();
    _drinkProvider = context.read<DrinkProvider>();
    _categoryProvider = context.read<CategoryProvider>();
    _loadData();
  }

Future<void> _loadData() async {
  var data = await _categoryProvider.get();
  setState(() {
    result = data;
    category = result!.result;
    _isLoading = false;
  });
}

Future<void> _pickImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.image);

    if (result != null) {
      File file = File(result.files.single.path!);
      final bytes = file.readAsBytesSync();
      setState(() {
        base64Image = base64Encode(bytes);
      });
    }
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
        _descriptionColor = Colors.red; // Change color to red on empty field
      });
      return false;
    }
    if ((controller.text.length<2 || controller.text.length>50) && isName)
    {

        setState(() {
        _nameColor = Colors.red; // Change color to red on invalid format
      });
      return false;
    }
    if ((controller.text.length<2 || controller.text.length>1000) && !isName)
    {

        setState(() {
        _descriptionColor = Colors.red; // Change color to red on invalid format
      });
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
        _descriptionColor = Colors.black; // Change color to red on invalid format
      });
      }
    return true;
  }

  bool validateCost(TextEditingController controller) {
    double value;
    if (controller.text.isEmpty) {
      setState(() {
        _costColor = Colors.red; // Change color to red on empty field
      });
      return false;
    } 
    try{
      value = double.parse(controller.text);
    }
    catch (e)
    {
      setState(() {
        _costColor = Colors.red; // Change color to red on empty field
      });
      return false;
    }
    if (value<=0 || value> 1000) {
      setState(() {
        _costColor = Colors.red; // Change color to red on empty field
      });
      return false;
    }
    setState(() {
        _costColor = Colors.black; // Change color to red on empty field
      });
    return true;
  }

  bool validateAlc(TextEditingController controller) {
    double value;
    if (controller.text.isEmpty) {
      setState(() {
        _alcoholColor = Colors.red; // Change color to red on empty field
      });
      return false;
    } 
    try{
      value = double.parse(controller.text);
    }
    catch (e)
    {
      setState(() {
        _alcoholColor = Colors.red; // Change color to red on empty field
      });
      return false;
    }
    if (value<0 || value> 70) {
      setState(() {
        _alcoholColor = Colors.red; // Change color to red on empty field
      });
      return false;
    }
    setState(() {
        _alcoholColor = Colors.black; // Change color to red on empty field
      });
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreenWidget(isJelovnikPressed: false,
    isKorisniciPressed: false,
    isMojProfilPressed: false,
    isPostavkePressed: false,
    isRecenzijePressed: false,
    isRezervacijePressed: false,
    isUposleniciPressed: false,
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
    Container(
      width: 140, // width and height to maintain square shape
      height: 140,
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(10), // Optional for rounded corners
        image: DecorationImage(
          image: ((widget.drink!=null && widget.drink!.drinkImage!= null) && (widget.drink!.drinkImage!= "" && base64Image == null))
              ? imageFromBase64String(widget.drink!.drinkImage!).image
              : (base64Image != null)
                  ? imageFromBase64String(base64Image!).image
                  : AssetImage('assets/images/eRestoranteDefault.jpg') as ImageProvider,
          fit: BoxFit.cover,
        ),
      ),
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
                      (widget.drink!=null)?
                      Text(
                        'Prepravite piće ${widget.drink!.drinkName!}',
                        style: TextStyle(
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold,
                          color: Color.fromRGBO(111, 63, 189, 0.612),
                        ),
                        textAlign: TextAlign.center,
                      ):
                      Text(
                        'Dodajte piće',
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
                        labelText: 'Ime pića',
                        icon: Icons.info,
                        color: _nameColor,
                        onChanged: (value) => validateName(widget._nameController, true),
                        errorText: _nameColor == Colors.red
                            ? 'Ime nije ok. Ime može imati min 2 slova i max 50'
                            : null,
                      ),
                      SizedBox(height: 5.0),
                      (widget.drink!=null)?
                      Text(
                        "Ime pića je bilo: ${widget.drink!.drinkName}"
                      ):
                      SizedBox.shrink(),
                      SizedBox(height: 10.0),
                      _buildTextField(
                        controller: widget._descriptionController,
                        labelText: 'Opis',
                        icon: Icons.info,
                        color: _descriptionColor,
                        onChanged: (value) => validateName(widget._descriptionController, false),
                        errorText: _descriptionColor == Colors.red
                            ? 'Opis nije ok. Opis može imati min 2 slova i max 1000'
                            : null,
                      ),
                      SizedBox(height: 5.0),
                      (widget.drink!=null)?
                      Text(
                        "Opis je bio: ${widget.drink!.drinkDescription!}"
                      ):
                      SizedBox.shrink(),
                      SizedBox(height: 10.0),
                      _buildNumberField(
                        controller: widget._costController,
                        labelText: 'Cijena',
                        icon: Icons.numbers,
                        color: _costColor,
                        onChanged: (value) => validateCost(widget._costController),
                        errorText: _costColor == Colors.red
                            ? 'Cijena nije ok. Mora biti u intervalima od 0 do 1000'
                            : null,
                      ),
                      SizedBox(height: 5.0),
                      (widget.drink!=null)?
                      Text(
                        "Cijena je bila: ${widget.drink!.drinkCost.toString()}"
                      ):
                       SizedBox.shrink(),
                      SizedBox(height: 10.0),
                      _buildNumberField(
                        controller: widget._alcoholController,
                        labelText: 'Procenat alkohola',
                        icon: Icons.numbers,
                        color: _alcoholColor,
                        onChanged: (value) => validateAlc(widget._alcoholController),
                        errorText: _alcoholColor == Colors.red
                            ? 'Procenat alkohola nije okay. Može biti u intervalu od 0 do 70'
                            : null,
                      ),
                      SizedBox(height: 5.0),
                      (widget.drink!=null)?
                      Text(
                        "Procenat alkohola je bio: ${widget.drink!.drinkAlcoholPerc.toString()}%"
                      ):
                       SizedBox.shrink(),
                      SizedBox(height: 10.0),
                      (widget.drink!=null)?
                      SizedBox.shrink():
                      DropdownButton<String>(
                            value: selectedCategory,
                            hint: Text("Izaberite kategoriju"),
                            onChanged: (String? newValue) {
                              setState(() {
                                selectedCategory = newValue;
                              });
                            },
                            items: category.map<DropdownMenuItem<String>>((CategoryC value) {
                              return DropdownMenuItem<String>(
                                value: value.categoryId.toString(),
                                child: Text(value.categoryName!),
                              );
                            }).toList(),
                          ),
                      SizedBox(height: 10.0),
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

Widget _buildNumberField({
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
    keyboardType: TextInputType.numberWithOptions(signed: true, decimal: true),
    inputFormatters: [
      FilteringTextInputFormatter.allow(RegExp(r'[0-9.]')),
    ],
    onChanged: (value) {
      onChanged(value);
    },
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
              builder: (context) => DrinksScreen(),
            ),
          );
        },
        child: Text('Odustani'),
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
          if((!validateName(widget._nameController,true) || !validateName(widget._descriptionController,false)) || (!validateCost(widget._costController)))
          {
            return;
          }
          DrinkUpdate newDrink;
          if(widget.drink!=null)
          {
            if(base64Image==null)
            {
              newDrink=DrinkUpdate(widget._nameController.text, widget._descriptionController.text, double.parse(widget._costController.text), double.parse(widget._alcoholController.text),widget.drink!.drinkImage);
            }
            else
            {
              newDrink=DrinkUpdate(widget._nameController.text, widget._descriptionController.text, double.parse(widget._costController.text), double.parse(widget._alcoholController.text),base64Image);
            }
            await _drinkProvider.update(widget.drink!.drinkId!,newDrink);
            showDialog(
              barrierDismissible: false,
                                        context: context,
                                        builder: (BuildContext context) {
                                          return StatefulBuilder(
                                            builder: (context, setState) {
                                              return AlertDialog(
                                                title: Text(
                                                  "Uspješno ažurirano piće",
                                                  textAlign: TextAlign.center,
                                                ),
                                                content: Column(
                                                  mainAxisSize: MainAxisSize.min,
                                                  children: [
                                                    Text(
                                                      "Uspješno ste ažurirali piće!",
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
                                                          Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                              builder: (context) => DrinksScreen(),
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
            
          }
          else if(widget.drink==null)
          {
            if(selectedCategory==null ||selectedCategory!.isEmpty)
            {
              return;
            }
            base64Image ??= "";
            double cost = double.parse(widget._costController.text);
            double alco = double.parse(widget._alcoholController.text);
            int categoryId= int.parse(selectedCategory!);
            DrinkInsert newDrink=DrinkInsert(widget._nameController.text, widget._descriptionController.text,cost,alco,base64Image,categoryId);
            await _drinkProvider.insert(newDrink);
            showDialog(
              barrierDismissible: false,
              context: context,
              builder: (BuildContext context) {
                return StatefulBuilder(
                  builder: (context, setState) {
                    return AlertDialog(
                      title: Text(
                        "Uspješno dodano piće",
                        textAlign: TextAlign.center,
                      ),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "Uspješno ste dodali novo piće!",
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () async {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DrinksScreen(),
                              ),
                            );
                          },
                          child: const Text("Ok"),
                        ),
                      ],
                    )
                    );
                  },
                );
              },
            );
          }
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