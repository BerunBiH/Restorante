import 'dart:convert';

import 'package:erestorante_mobile/models/dish.dart';
import 'package:erestorante_mobile/models/orderDishInsert.dart';
import 'package:erestorante_mobile/models/orderDishes.dart';
import 'package:erestorante_mobile/models/orderInsert.dart';
import 'package:erestorante_mobile/models/orders.dart';
import 'package:erestorante_mobile/models/search_result.dart';
import 'package:erestorante_mobile/providers/dish_provider.dart';
import 'package:erestorante_mobile/providers/order_dish_provider.dart';
import 'package:erestorante_mobile/providers/order_provider.dart';
import 'package:erestorante_mobile/screens/drinks_screen.dart';
import 'package:erestorante_mobile/screens/order_screen.dart';
import 'package:erestorante_mobile/utils/util.dart';
import 'package:erestorante_mobile/widgets/master_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DishesScreen extends StatefulWidget {
  Order? lastOrder;
  int? cartCount;

  DishesScreen({super.key, this.cartCount, this.lastOrder});

  @override
  State<DishesScreen> createState() => _DishesScreenState();
}

class _DishesScreenState extends State<DishesScreen> {
  final TextEditingController _searchController = TextEditingController();
  late DishProvider _dishProvider;
  late OrderProvider _orderProvider;
  late OrderDishesProvider _orderDishesProvider;
  SearchResult<Dish>? resultD;
  SearchResult<Order>? resultO;
  SearchResult<OrderDishes>? resultOD;
  bool authorised = false;
  bool _isLoading = true;
  late List<ImageProvider> _dishImages;
  List<bool> _isExpandedList = [];
  List<int> _dishCounts = [];
  late OrderInsert orderInsert;
  List<OrderDishes> dishes=[];
  late Order lastOrder;
  int cartCount = 0; // Cart count

  @override
  void initState() {
    super.initState();
    _dishProvider = context.read<DishProvider>();
    _orderProvider = context.read<OrderProvider>();
    _orderDishesProvider = context.read<OrderDishesProvider>();
    _loadData();
  }

  Future<void> _loadData() async {
    var dataD = await _dishProvider.get();
    OrderInsert newOrder=OrderInsert(Info.id);
    if(widget.lastOrder==null)
    {
      await _orderProvider.insert(newOrder);
      
    }
    var dataO = await _orderProvider.get(filter: {
            'CustomerId': Info.id
          });
    


    setState(() {
      if(widget.cartCount!=null)
      {
        cartCount=widget.cartCount!;
      }
      if(widget.lastOrder!=null)
      {
        lastOrder=widget.lastOrder!;
      }
      else {
        lastOrder=dataO.result.last;
      }  
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
    return (_isLoading)
          ? Center(child: CircularProgressIndicator())
          :MasterScreenWidget(
      isJelovnikPressed: true,
      isKorpaPressed: false,
      isMojProfilPressed: false,
      isPostavkePressed: false,
      isRecenzijePressed: false,
      isRezervacijePressed: false,
      orderExists: true,
      activeOrderId: lastOrder.ordersId,
      child: Scaffold(
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
                          childAspectRatio: 3 / 3,
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
        Expanded(
          child: Card(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () async {
                          Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DrinksScreen(cartCount: cartCount, lastOrder: lastOrder,),
                      ),
                    );

                        },
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
                      Stack(
                        children: [
                          IconButton(
                            icon: Icon(Icons.shopping_cart),
                            iconSize: 30.0,
                            onPressed: () {
                              Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => OrderScreen(cartCount: cartCount, lastOrder: lastOrder,),
                              ),
                              );
                            },
                          ),
                          if (cartCount > 0) // Show badge if cartCount > 0
                            Positioned(
                              right: 0,
                              child: Container(
                                padding: EdgeInsets.all(6),
                                decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                constraints: BoxConstraints(
                                  minWidth: 20,
                                  minHeight: 20,
                                ),
                                child: Text(
                                  '$cartCount',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 5.0),
                ],
              ),
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
                        fontSize: 16.0,
                        color: Colors.black,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 8),
                    Text(
                      "Ako želite naše preporuke za ovo jelo, pritisnite ikonu za info, ako želite naruciti jelo pritisnite ikonu +",
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.black,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            _showInfoDialog(dish);
                          },
                          child: const Text("+",
                          style: TextStyle(fontSize: 20),),
                        ),
                        SizedBox(width: 20.0,),
                                            IconButton(
                      icon: Icon(Icons.info_outline),
                      color: Colors.deepPurpleAccent,
                      alignment: Alignment.center,
                      onPressed: () {
                        _recommendDialog(dish);
                      }
                    ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

void _showInfoDialog(Dish dish) {
  int _counter = 1; // Initialize counter variable

  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text("Odaberite kolicinu"),
        content: StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Odaberite koliko puta želite jelo naručiti:",
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Minus Button
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          if (_counter > 1) {
                            _counter--;
                          }
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        shape: CircleBorder(),
                        padding: EdgeInsets.all(15.0),
                        backgroundColor: Colors.white,
                        side: BorderSide(color: Colors.blueAccent),
                        overlayColor: Colors.blueAccent.withOpacity(0.2),
                      ),
                      child: Icon(Icons.remove, color: Colors.blueAccent),
                    ),

                    // Number Display
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Text(
                        '$_counter',
                        style: TextStyle(
                          fontSize: 24,
                          color: Colors.blueAccent,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    // Plus Button
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          if (_counter < 100) {
                            _counter++;
                          }
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        shape: CircleBorder(),
                        padding: EdgeInsets.all(15.0),
                        backgroundColor: Colors.white,
                        side: BorderSide(color: Colors.blueAccent),
                        overlayColor: Colors.blueAccent.withOpacity(0.2),
                      ),
                      child: Icon(Icons.add, color: Colors.blueAccent),
                    ),
                  ],
                ),
              ],
            );
          },
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
                  surfaceTintColor: Color.fromARGB(255, 0, 255, 21),
                  overlayColor: Colors.green,
                  padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
                ),
                onPressed: () async {
                  try {
                    OrderDishInsert newOrderDish=OrderDishInsert(_counter, lastOrder.ordersId, dish.dishID);
                    await _orderDishesProvider.insert(newOrderDish);
                    setState(() {
                      cartCount++;
                    });
                    Navigator.pop(context);
                  } catch (e) {
                    _showFailureDialog();
                  }
                },
                child: const Text("Odaberi"),
              ),
              SizedBox(width: 10),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  surfaceTintColor: const Color.fromARGB(255, 255, 0, 0),
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

  void _showFailureDialog() {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Upsss, nesto nije okay!"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Probajte opet kasnije!",
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
  }
  Future<void> _recommendDialog(Dish dish) async {
    List<Dish>recommendDishes=[];
    var resultRec= await _dishProvider.getRecommended(dish.dishID!);
    recommendDishes=resultRec.result!;

    return showDialog<void>(
      context: context,
      barrierDismissible: false, 
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Preporuke za jelo!', textAlign: TextAlign.center,),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Uz jelo ${dish.dishName} žeimo Vam srdačno također preporučiti da probate:', textAlign: TextAlign.center,),
                recommendDishes.isNotEmpty?Text('${recommendDishes[0].dishName},${recommendDishes[1].dishName},${recommendDishes[2].dishName},', textAlign: TextAlign.center,style: TextStyle(
                  fontWeight: FontWeight.bold,
                        fontSize: 24.0,
                        color: Colors.black,
                ),):
                Text("Upsss, nemamo Vam sta preporuciti :(")
              ],
            ),
          ),
          actions: <Widget>[
            Center(
              child: TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
          ],
        );
      },
    );
  }

}

