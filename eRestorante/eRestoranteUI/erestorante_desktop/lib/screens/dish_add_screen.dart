import 'dart:convert';
import 'dart:io';

import 'package:erestorante_desktop/models/categoryC.dart';
import 'package:erestorante_desktop/models/dish.dart';
import 'package:erestorante_desktop/models/dishInsert.dart';
import 'package:erestorante_desktop/models/dishUpdate.dart';
import 'package:erestorante_desktop/models/search_result.dart';
import 'package:erestorante_desktop/models/user.dart';
import 'package:erestorante_desktop/providers/category_provider.dart';
import 'package:erestorante_desktop/providers/dish_provider.dart';
import 'package:erestorante_desktop/providers/user_provider.dart';
import 'package:erestorante_desktop/screens/dishes_screen.dart';
import 'package:erestorante_desktop/screens/main_menu_sreen.dart';
import 'package:erestorante_desktop/screens/profile_screen.dart';
import 'package:erestorante_desktop/utils/util.dart';
import 'package:erestorante_desktop/widgets/master_screen.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

class DishAddScreen extends StatefulWidget {
  Dish? dish;
  bool? backMain=false;
  final TextEditingController _costController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  DishAddScreen({super.key, this.dish, this.backMain});

  @override
  State<DishAddScreen> createState() => _DishAddScreenState();
}

class _DishAddScreenState extends State<DishAddScreen> {

  Color _costColor = Colors.black;
  Color _nameColor= Colors.black;
  Color _descriptionColor= Colors.black;
  late DishProvider _dishProvider;
  bool _isLoading = true;
  late bool _isSpeciality;
  late User user;
  String? base64Image;
  String? selectedCategory;
  SearchResult<CategoryC>? result;
  late List<CategoryC> category;
  late CategoryProvider _categoryProvider;
  late ImageProvider _dishImage;

  @override
  void initState() {
    super.initState();
    _dishProvider = context.read<DishProvider>();
    _categoryProvider = context.read<CategoryProvider>();
    _loadData().then((_) {
      _dishImage = (widget.dish!=null && (widget.dish!.dishImage != "" && base64Image == null))
          ? imageFromBase64String(widget.dish!.dishImage!).image
          : AssetImage('assets/images/eRestoranteDefault.jpg') as ImageProvider;
    });
  }

Future<void> _loadData() async {
  var data = await _categoryProvider.get();
  setState(() {
    result = data;
    category = result!.result;
    _isLoading = false;
    _isSpeciality = widget.dish?.speciality ?? false;

    if(widget.dish!=null)
    {
      widget._costController.text=widget.dish!.dishCost.toString();
      widget._descriptionController.text=widget.dish!.dishDescription!;
      widget._nameController.text=widget.dish!.dishName!;
    }
  });
}

Future<void> _pickImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.image);

    if (result != null) {
      File file = File(result.files.single.path!);
      final bytes = file.readAsBytesSync();
      setState(() {
        base64Image = base64Encode(bytes);
        _dishImage = imageFromBase64String(base64Image!).image;
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

  @override
  Widget build(BuildContext context) {
    return MasterScreenWidget(isJelovnikPressed: false,
    isKorisniciPressed: false,
    isMojProfilPressed: false,
    isPostavkePressed: false,
    isRecenzijePressed: false,
    isRezervacijePressed: false,
    isUposleniciPressed: false,
    isOrdersPressed: false,
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
          image: _dishImage,
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
                      (widget.dish!=null)?
                      Text(
                        'Prepravite jelo ${widget.dish!.dishName!}',
                        style: TextStyle(
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold,
                          color: Color.fromRGBO(111, 63, 189, 0.612),
                        ),
                        textAlign: TextAlign.center,
                      ):
                      Text(
                        'Dodajte jelo',
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
                        labelText: 'Ime jela',
                        icon: Icons.info,
                        color: _nameColor,
                        onChanged: (value) => validateName(widget._nameController, true),
                        errorText: _nameColor == Colors.red
                            ? 'Ime nije ok. Ime može imati min 2 slova i max 50'
                            : null,
                      ),
                      SizedBox(height: 5.0),
                      (widget.dish!=null)?
                      Text(
                        "Ime jela je bilo: ${widget.dish!.dishName}"
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
                      (widget.dish!=null)?
                      Text(
                        "Opis je bio: ${widget.dish!.dishDescription!}"
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
                      (widget.dish!=null)?
                      Text(
                        "Cijena je bila: ${widget.dish!.dishCost.toString()}"
                      ):
                       SizedBox.shrink(),
                       SizedBox(height: 10.0),
                      _buildBoolField(
                        isSpeciality: _isSpeciality,
                        onChanged: (value) {
                          setState(() {
                            _isSpeciality = value;
                          });
                        },
                      ),
                      SizedBox(height: 5.0),
                      if (widget.dish != null)
                        Text(
                          "Jelo: ${_isSpeciality ? 'Jest specijalitet' : 'Nije specijalitet'}",
                        ),
                      SizedBox(height: 10.0),
                      (widget.dish!=null)?
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
Widget _buildBoolField({
  required bool isSpeciality,
  required Function(bool) onChanged,
}) {
  return CheckboxListTile(
    value: isSpeciality,
    onChanged: (bool? newValue) {
      if (newValue != null) {
        onChanged(newValue);
      }
    },
    title: Text(
      isSpeciality ? 'Specijalitet: DA' : 'Specijalitet: NE',
      style: TextStyle(
        fontWeight: FontWeight.bold,
        color: isSpeciality ? Colors.green : Colors.red,
      ),
    ),
    activeColor: Colors.green,
    checkColor: Colors.white,
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
          if(widget.backMain!=null && widget.backMain!)
          {
            Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MainMenuSreen(),
            ),
          );
          }
          else{
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DishesScreen(),
            ),
          );

          }
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
          DishUpdate newDish;
          if(widget.dish!=null)
          {
            if(base64Image==null)
            {
              newDish=DishUpdate(widget._nameController.text, widget._descriptionController.text, double.parse(widget._costController.text), widget.dish!.dishImage,_isSpeciality);
            }
            else
            {
              newDish=DishUpdate(widget._nameController.text, widget._descriptionController.text, double.parse(widget._costController.text), base64Image,_isSpeciality);
            }
            await _dishProvider.update(widget.dish!.dishID!,newDish);
            showDialog(
              barrierDismissible: false,
                                        context: context,
                                        builder: (BuildContext context) {
                                          return StatefulBuilder(
                                            builder: (context, setState) {
                                              return AlertDialog(
                                                title: Text(
                                                  "Uspješno ažurirano jelo",
                                                  textAlign: TextAlign.center,
                                                ),
                                                content: Column(
                                                  mainAxisSize: MainAxisSize.min,
                                                  children: [
                                                    Text(
                                                      "Uspješno ste ažurirali jelo!",
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
                                                              builder: (context) => DishesScreen(),
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
          else if(widget.dish==null)
          {
            if(selectedCategory==null ||selectedCategory!.isEmpty)
            {
              return;
            }
            base64Image ??= "";
            double cost = double.parse(widget._costController.text);
            int categoryId= int.parse(selectedCategory!);
            DishInsert newDish=DishInsert(widget._nameController.text, widget._descriptionController.text,cost, categoryId, base64Image,_isSpeciality);
            await _dishProvider.insert(newDish);
            showDialog(
              barrierDismissible: false,
              context: context,
              builder: (BuildContext context) {
                return StatefulBuilder(
                  builder: (context, setState) {
                    return AlertDialog(
                      title: Text(
                        "Uspješno dodano jelo",
                        textAlign: TextAlign.center,
                      ),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "Uspješno ste dodali novo jelo!",
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () async {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DishesScreen(),
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