import 'dart:convert';

import 'package:erestorante_mobile/models/dish.dart';
import 'package:erestorante_mobile/models/search_result.dart';
import 'package:erestorante_mobile/providers/dish_provider.dart';
import 'package:erestorante_mobile/utils/util.dart';
import 'package:erestorante_mobile/widgets/master_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DishesScreen extends StatefulWidget {
  const DishesScreen({super.key});

  @override
  State<DishesScreen> createState() => _DishesScreenState();
}

class _DishesScreenState extends State<DishesScreen> {
  final TextEditingController _searchController = TextEditingController();
  late DishProvider _dishProvider;
  SearchResult<Dish>? resultD;
  bool authorised = false;
  bool _isLoading = true;
  late List<ImageProvider> _dishImages;
  List<bool> _isExpandedList = [];

  @override
  void initState() {
    super.initState();
    _dishProvider = context.read<DishProvider>();
    _loadData();
  }

  Future<void> _loadData() async {
    var dataD = await _dishProvider.get();

    setState(() {
      resultD = dataD;
      _dishImages = resultD!.result.map((dish) {
        if (dish.dishImage != null && dish.dishImage!.isNotEmpty) {
          final image = Image.memory(base64Decode(dish.dishImage!));
          precacheImage(image.image, context);
          return image.image;
        } else {
          final image = AssetImage('assets/images/RestoranteLogo.png');
          precacheImage(image, context);
          return image;
        }
      }).toList();

      _isExpandedList = List<bool>.filled(resultD!.result.length, false);
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreenWidget(
      isJelovnikPressed: true,
      isKorpaPressed: false,
      isMojProfilPressed: false,
      isPostavkePressed: false,
      isRecenzijePressed: false,
      isRezervacijePressed: false,
      child: (_isLoading)
          ? Center(child: CircularProgressIndicator())
          : Scaffold(
              body: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    _buildSearch(),
                    Expanded(
                      child: GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 1,
                          crossAxisSpacing: 16.0,
                          mainAxisSpacing: 16.0,
                          childAspectRatio: 3 / 2,
                        ),
                        itemCount: resultD!.result.length,
                        itemBuilder: (context, index) {
                          if (resultD != null && index < resultD!.result.length) {
                            final dish = resultD!.result[index];
                            return _foodCardBuilder(dish, _dishImages[index], index);
                          } else {
                            return SizedBox.shrink();
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  Widget _buildSearch() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Card(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () async {},
                      child: Text('Pića'),
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        overlayColor: Colors.green,
                        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
                        minimumSize: Size(120, 50),
                      ),
                    ),
                    SizedBox(width: 20.0),
                    ElevatedButton(
                      onPressed: () async {},
                      child: Text('Korpa'),
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        overlayColor: Colors.green,
                        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
                        minimumSize: Size(120, 50),
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 5.0),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _foodCardBuilder(Dish dish, ImageProvider image, int index) {
    return GestureDetector(
      onTap: () => setState(() {
        _isExpandedList[index] = !_isExpandedList[index];
      }),
      child: Card(
        elevation: 4.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12.0),
              child: AnimatedOpacity(
                opacity: _isExpandedList[index] ? 0.2 : 1.0,
                duration: Duration(milliseconds: 300),
                child: Image(
                  image: image,
                  width: double.infinity,
                  height: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Center(
              child: AnimatedOpacity(
                opacity: _isExpandedList[index] ? 1.0 : 0.0,
                duration: Duration(milliseconds: 300),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      dish.dishName!,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24.0,
                        color: Colors.black,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 8),
                    Text(
                      dish.dishDescription!,
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.black,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 8),
                    Text(
                      "Cijena: ${dish.dishCost!.toString()}KM",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0,
                        color: Colors.black,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 8,
              left: 8,
              right: 8,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: Icon(Icons.delete),
                    color: Colors.red,
                    onPressed: () {
                      _showDeleteDialog(dish);
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.info_outline),
                    color: Colors.deepPurpleAccent,
                    onPressed: () {
                      // Navigator.push to the details screen
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.check),
                    color: Colors.green,
                    onPressed: () {
                      _showEditDialog(dish);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showDeleteDialog(Dish dish) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Da li ste sigurni da želite izbrisati jelo?"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Ako želite izbrisati jelo pritisnite dugme ${"Izbriši"} ako ne želite, pritisnite dugme ${"Odustani"}",
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
            ],
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    overlayColor: Colors.green,
                    padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
                  ),
                  onPressed: () async {
                    await _dishProvider.delete(dish.dishID!);
                    Navigator.pop(context);
                    _showSuccessDialog();
                  },
                  child: const Text("Izbriši"),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    overlayColor: Colors.red,
                    padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("Odustani"),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  void _showEditDialog(Dish dish) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Da li ste sigurni da želite urediti jelo?"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Ako želite urediti jelo pritisnite dugme ${"Uredi"} ako ne želite, pritisnite dugme ${"Odustani"}",
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
            ],
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    overlayColor: Colors.green,
                    padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
                  ),
                  onPressed: () {
                    // Navigate to the edit screen
                  },
                  child: const Text("Uredi"),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    overlayColor: Colors.red,
                    padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("Odustani"),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  void _showSuccessDialog() {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Uspješno izbrisano jelo"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Uspješno ste izbrisali jelo!",
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
            ],
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => DishesScreen()),
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
  }
}
