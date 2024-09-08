import 'dart:ui';

import 'package:cross_scroll/cross_scroll.dart';
import 'package:erestorante_mobile/models/categoryC.dart';
import 'package:erestorante_mobile/models/drink.dart';
import 'package:erestorante_mobile/models/orderDishes.dart';
import 'package:erestorante_mobile/models/orderDrinks.dart';
import 'package:erestorante_mobile/models/orderUpdate.dart';
import 'package:erestorante_mobile/models/orders.dart';
import 'package:erestorante_mobile/models/ratingDishes.dart';
import 'package:erestorante_mobile/models/search_result.dart';
import 'package:erestorante_mobile/providers/dish_provider.dart';
import 'package:erestorante_mobile/providers/drink_provider.dart';
import 'package:erestorante_mobile/providers/order_dish_provider.dart';
import 'package:erestorante_mobile/providers/order_drink_provider.dart';
import 'package:erestorante_mobile/providers/order_provider.dart';
import 'package:erestorante_mobile/screens/dishes_screen.dart';
import 'package:erestorante_mobile/screens/payPal_screen.dart';
import 'package:erestorante_mobile/utils/util.dart';
import 'package:erestorante_mobile/widgets/master_screen.dart';
import 'package:flutter/material.dart';
import 'package:erestorante_mobile/models/dish.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class OrderScreen extends StatefulWidget {
  Order lastOrder;
  int cartCount;

  OrderScreen({super.key, required this.lastOrder, required this.cartCount});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  bool _isLoading = true;
  late DishProvider _dishProvider;
  late DrinkProvider _drinkProvider;
  late OrderProvider _orderProvider;
  late OrderDishesProvider _orderDishesProvider;
  late OrderDrinksProvider _orderDrinksProvider;
  SearchResult<Dish>? resultD;
  SearchResult<Drink>? resultDrink;
  SearchResult<Order>? resultO;
  List<OrderDishes> orderDishes = [];
  List<OrderDrinks> orderDrinks = [];
  List<Dish> dishes=[];
  List<Drink> drinks=[];
  late Order lastOrder;
  int cartCount = 0;
  double totalPrice=0.0;

  @override
  void initState() {
    super.initState();
    _dishProvider = context.read<DishProvider>();
    _drinkProvider = context.read<DrinkProvider>();
    _orderProvider = context.read<OrderProvider>();
    _orderDishesProvider = context.read<OrderDishesProvider>();
    _orderDrinksProvider = context.read<OrderDrinksProvider>();
    _loadData();
  }

  Future<void> _loadData() async {
      resultD = await _dishProvider.get();
      resultDrink = await _drinkProvider.get();
      resultO = await _orderProvider.get(filter: {
            'CustomerId': Info.id
          });
    setState(() {
      cartCount=widget.cartCount;
      lastOrder =resultO!.result.last;
      if(lastOrder.orderDishes!=null && lastOrder.orderDishes!.isNotEmpty)
      {
        for(var dishOrder in lastOrder.orderDishes!)
        {
          if(resultD!=null)
          {
            for(var dish in resultD!.result)
            {
              if(dish.dishID==dishOrder.dishId)
              {
                dishes.add(dish);
              }
            }
          }
        }
        orderDishes=lastOrder.orderDishes!;
      }
      if(lastOrder.orderDrinks!=null && lastOrder.orderDrinks!.isNotEmpty)
      {
        for(var drinkOrder in lastOrder.orderDrinks!)
        {
          if(resultDrink!=null)
          {
            for(var drink in resultDrink!.result)
            {
              if(drink.drinkId==drinkOrder.drinkId)
              {
                drinks.add(drink);
              }
            }
          }
        }
        orderDrinks=lastOrder.orderDrinks!;
      }
      for (int i = 0; i < orderDishes.length; i++) {
        final orderDish = orderDishes[i];
        final dishCost = dishes[i].dishCost;

        if (dishCost != null && orderDish.orderQuantity != null) {
          totalPrice += dishCost * orderDish.orderQuantity!;
        }
      }

      for (int i = 0; i < orderDrinks.length; i++) {
        final orderDrink = orderDrinks[i];
        final drinkCost = drinks[i].drinkCost;

        if (drinkCost != null && orderDrink.orderQuantity != null) {
          totalPrice += drinkCost * orderDrink.orderQuantity!;
        }
      }

      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return (_isLoading)
          ? Center(child: CircularProgressIndicator()): MasterScreenWidget(
      isJelovnikPressed: false,
      isKorpaPressed: false,
      isMojProfilPressed: false,
      isPostavkePressed: false,
      isRecenzijePressed: true,
      isRezervacijePressed: false,
      orderExists: true,
      activeOrderId: lastOrder.ordersId,
      child: 
        Container(
        child:
      Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child:Column(
          children: [ 
            _buildSearch(),
            Expanded(child: _buildDataListView()),
            _buildRegisterButton(context)
          ],
        ),
    )
      ]
      )
          )
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
                      SizedBox(width: 5.0,),
                      ElevatedButton(
                        onPressed: () async {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DishesScreen(cartCount: cartCount, lastOrder: lastOrder,),
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
                    ],
                  ),
                  const SizedBox(height: 5.0),
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      style: TextStyle(fontSize: 16, color: Colors.black), // Base text style
                      children: [
                        TextSpan(
                          text: 'Ispod je ispod je vaša narudžba, ako je sve okay, nstavite dalje prema placanju, ako nije vratite se nazad na uređivanje naruđbe.',
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Container _buildRegisterButton(BuildContext context) {
    return Container(
      width: 400,
      height: 100,
      child: Card(
        child: SingleChildScrollView(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Ukupno za platiti je $totalPrice KM'),
                ElevatedButton(
                          onPressed: () {
                            _showDiningChoiceDialog();
                          },
                          child: Text('Nastavi'),
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            surfaceTintColor:  Colors.green,
                            overlayColor: Colors.green,
                            padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
                          ),
                ),
              ],
            )
        )
      )
      );
  }
  
Widget _buildDataListView() {
  return SingleChildScrollView(
    child: Column(
      children: [
        SingleChildScrollView(
          child: DataTable(
            showCheckboxColumn: false,
            columns: [
              const DataColumn(
                label: Expanded(
                  child: Text(
                    'Jelo',
                    style: TextStyle(fontStyle: FontStyle.italic),
                  ),
                ),
              ),
              const DataColumn(
                label: Expanded(
                  child: Text(
                    'Kolicina',
                    style: TextStyle(fontStyle: FontStyle.italic),
                  ),
                ),
              ),
              const DataColumn(
                label: Expanded(
                  child: Text(
                    'Ukupna cijena',
                    style: TextStyle(fontStyle: FontStyle.italic),
                  ),
                ),
              ),
              const DataColumn(
                label: Expanded(
                  child: Text(
                    'Izbriši',
                    style: TextStyle(fontStyle: FontStyle.italic),
                  ),
                ),
              ),
            ],
            rows: List<DataRow>.generate(
              orderDishes.length, 
              (index) {
                final orderDish = orderDishes[index];
                final dishName = dishes.isNotEmpty && dishes.length > index
                    ? dishes[index].dishName!
                    : 'N/A';
                final price = dishes.isNotEmpty && dishes.length > index
                    ? dishes[index].dishCost!*orderDish.orderQuantity!
                    : 'N/A'; 
        
                return DataRow(
                  onSelectChanged: (selected) {
                    if (selected == true) {
                      // handle selection logic
                    }
                  },
                  cells: [
                    DataCell(Text(dishName)),
                    DataCell(Text('${orderDish.orderQuantity}')),
                    DataCell(Text('$price KM')),
                      DataCell(IconButton(
            icon: Icon(Icons.delete),
            color: Colors.red,      
            onPressed: () {
             showDialog(
              barrierDismissible: false,
                                      context: context,
                                      builder: (BuildContext context) {
                                        return StatefulBuilder(
                                          builder: (context, setState) {
                                            return AlertDialog(
                                              title: Text(
                                                "Da li ste sigurni da želite izbrisati jelo?",
                                                textAlign: TextAlign.center,
                                              ),
                                              content: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Text(
                                                    "Ako želite izbrisati jelo sa narudzbe pritisnite dugme ${"Izbriši"} ako ne želite, pritisnite dugme ${"Odustani"}",
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
                                                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          overlayColor: Colors.green,
                          padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
                        ),
                                                      onPressed: () async {
                                                        await _orderDishesProvider.delete(orderDish.orderDishId!);
                                                        showDialog(
                                                          barrierDismissible: false,
                                      context: context,
                                      builder: (BuildContext context) {
                                        return StatefulBuilder(
                                          builder: (context, setState) {
                                            return AlertDialog(
                                              title: Text(
                                                "Uspješno izbrisano jelo",
                                                textAlign: TextAlign.center,
                                              ),
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
                crossAxisAlignment: CrossAxisAlignment.center,
                                                  children: [
                                                    ElevatedButton(
                                                      onPressed: () {
                                                        setState() {
                                                          cartCount--;
                                                        };
                                                        Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                builder: (context) => OrderScreen(cartCount: cartCount, lastOrder: lastOrder,),
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
                                                      child: const Text("Izbriši"),
                                                    ),
                                                    SizedBox(width: 10,),
                                                                                                    ElevatedButton(
                                                                                                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          overlayColor: Colors.red,
                          surfaceTintColor: const Color.fromARGB(255, 255, 0, 0),
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
                                      },
                                    );
            },
          ),),
           // Display price from second list
                  ],
                );
              },
            ),
          ),
        ),
        SizedBox(height: 20,),
                SingleChildScrollView(
                          child: DataTable(
                            showCheckboxColumn: false,
                            columns: [
                              const DataColumn(
                label: Expanded(
                  child: Text(
                    'Piće',
                    style: TextStyle(fontStyle: FontStyle.italic),
                  ),
                ),
                              ),
                              const DataColumn(
                label: Expanded(
                  child: Text(
                    'Kolicina',
                    style: TextStyle(fontStyle: FontStyle.italic),
                  ),
                ),
                              ),
                              const DataColumn(
                label: Expanded(
                  child: Text(
                    'Ukupna cijena',
                    style: TextStyle(fontStyle: FontStyle.italic),
                  ),
                ),
                              ),
                            ],
                            rows: List<DataRow>.generate(
                              orderDrinks.length, 
                              (index) {
                final orderDrink = orderDrinks[index];
                final drinkName = drinks[index].drinkName!;
                final price = drinks[index].drinkCost!*orderDrink.orderQuantity!;
                        
                return DataRow(
                  onSelectChanged: (selected) {
                    if (selected == true) {
                      // handle selection logic
                    }
                  },
                  cells: [
                    DataCell(Text(drinkName)),
                    DataCell(Text('${orderDrink.orderQuantity}')),
                    DataCell(Text('$price KM')), // Display price from second list
                  ],
                );
                              },
                            ),
                          ),
                        ),
      ],
    ),
  );
}

void _showDiningChoiceDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Izaberite!", textAlign: TextAlign.center,),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Izaberite da li je jelo za ponjeti ili za ovdje!",
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
                  onPressed: () async {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PayPalScreen(totalAmount: totalPrice, lastOrder: lastOrder, cartCount: cartCount, takeOut: true,),
                      ),
                    );
                  },
                  child: const Text("Za ponjeti"),
                ),
                SizedBox(width: 20.0,),
                ElevatedButton(
                  onPressed: () async {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PayPalScreen(totalAmount: totalPrice, lastOrder: lastOrder, cartCount: cartCount, takeOut: false,),
                      ),
                    );
                  },
                  child: const Text("U restoranu"),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

}