import 'dart:async';

import 'package:cross_scroll/cross_scroll.dart';
import 'package:erestorante_mobile/models/dish.dart';
import 'package:erestorante_mobile/models/drink.dart';
import 'package:erestorante_mobile/models/orderDishes.dart';
import 'package:erestorante_mobile/models/orderDrinks.dart';
import 'package:erestorante_mobile/models/orderUpdate.dart';
import 'package:erestorante_mobile/models/orders.dart';
import 'package:erestorante_mobile/models/search_result.dart';
import 'package:erestorante_mobile/models/user.dart';
import 'package:erestorante_mobile/providers/dish_provider.dart';
import 'package:erestorante_mobile/providers/drink_provider.dart';
import 'package:erestorante_mobile/providers/order_provider.dart';
import 'package:erestorante_mobile/utils/util.dart';
import 'package:erestorante_mobile/widgets/master_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ArchiveOrderScreen extends StatefulWidget {
  const ArchiveOrderScreen({super.key});

  @override
  State<ArchiveOrderScreen> createState() => _ArchiveOrderScreenState();
}

class _ArchiveOrderScreenState extends State<ArchiveOrderScreen> {
  final TextEditingController _searchController = TextEditingController();
  late OrderProvider _orderProvider;
  late DishProvider _dishProvider;
  late DrinkProvider _drinkProvider;
  List<OrderDishes> orderDishes = [];
  List<OrderDrinks> orderDrinks = [];
  SearchResult<Dish>? resultD;
  SearchResult<Drink>? resultDrink;
  SearchResult<User>? resultU;
  SearchResult<Order>? resultO;
  List<Dish> dishes=[];
  List<Drink> drinks=[];
  double totalPrice=0.0;
  bool authorised=false;
  bool _isLoading = true;
  bool _isSwipingHintVisible = true;
  double _swipePosition = 0.0;
  late Timer _swipeTimer;
 @override
  void initState() {
    super.initState();
    _orderProvider = context.read<OrderProvider>();
    _dishProvider = context.read<DishProvider>();
    _drinkProvider = context.read<DrinkProvider>();
    _loadData();
    _startSwipeHintAnimation();
  }
  Future<void> _loadData() async {
    var dataO = await _orderProvider.get(filter: {
            'CustomerId': Info.id
          });
    resultD = await _dishProvider.get();
    resultDrink = await _drinkProvider.get();

    setState(() {
      resultO = dataO;
      _isLoading = false;
    });
  }

  void _startSwipeHintAnimation() {
  _swipeTimer = Timer.periodic(Duration(seconds: 1), (timer) {
    if (mounted) {
      setState(() {
        _swipePosition = _swipePosition == 0.0 ? 50.0 : 0.0; 
      });
    }
  });
}

void _stopSwipeHintAnimation() {
  if (_isSwipingHintVisible) {
    setState(() {
      _isSwipingHintVisible = false;
    });
    _swipeTimer.cancel();
  }
}


  @override
  Widget build(BuildContext context) {
    return MasterScreenWidget(
      isJelovnikPressed: false,
      isKorpaPressed: true,
      isMojProfilPressed: false,
      isPostavkePressed: false,
      isRecenzijePressed: false,
      isRezervacijePressed: false,
      orderExists: false,
      child: (_isLoading) ?
      Center(child: CircularProgressIndicator()):
      GestureDetector(
              onPanDown: (_) => _stopSwipeHintAnimation(),
              child: Stack(
                children: [
                  _buildAuthorisation(),
                  if (_isSwipingHintVisible)
                    AnimatedPositioned(
                      duration: Duration(milliseconds: 300),
                      bottom: 100.0 ,
                      left: (_swipePosition + (MediaQuery.of(context).size.width / 2)) - 25,
                      child: Icon(Icons.arrow_forward, size: 70, color: Color.fromARGB(255, 149, 97, 233)),
                    ),
                ],
              ),
            ),
    );
  }

    Container _buildAuthorisation() {
    return Container(
        child:
        Column(
          children: [ 
            _buildSearch(),
            _buildDataListView(),
          ],
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
          child: Column(
            children: [
           GestureDetector(
             onTap: () async {
               DateTime? pickedDate = await showDatePicker(
                 context: context,
                 initialDate: DateTime.now(),
                 firstDate: DateTime(2000),
                 lastDate: DateTime(2100),
               );
          
               if (pickedDate != null) {
                 String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
                 _searchController.text = formattedDate;
          
                 var data = await _orderProvider.get(filter: {
                   'OrderDate': _searchController.text,
                   'CustomerId': Info.id
                 });
          
                 setState(() {
                   resultO = data;
                 });
               }
             },
             child: AbsorbPointer(
               child: TextField(
                 decoration: const InputDecoration(
                   labelText: 'Pretraga',
                   hintText: 'Pretrazite po datumu narudzbe.',
                   border: OutlineInputBorder(),
                   prefixIcon: Icon(Icons.date_range),
                 ),
                 controller: _searchController,
               ),
             ),
           ),
           const SizedBox(height: 20.0),
           const Text("Pretrazite po datumu narudzbe."),
            const SizedBox(height: 20.0),
                 ElevatedButton(
               onPressed: () async {
          
                 if(_searchController.text.isEmpty)
                   {
                     return;
                   }
          
                   var data = await _orderProvider.get();
                   
                 setState(() {
                   _searchController.text = "";
                   resultO = data;
                 });
                 },
               child: Text('Obriši pretragu'),
               style: ElevatedButton.styleFrom(
                 shape: RoundedRectangleBorder(
                   borderRadius: BorderRadius.circular(10.0),
                 ),
                 overlayColor: Colors.green,
                 padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
               ),
             ),
           const SizedBox(height: 20.0),
           const Text("Ispod vidite sve narudžbe koje ste imali od ranije, ako je prazno onda nemate narudzbi."),
            const SizedBox(height: 5.0),
            ],
          )
        )
      ),
    ],
    );
  }

  Widget _buildDataListView() {
    return Expanded(
        child:SingleChildScrollView(
          scrollDirection: Axis.vertical,
        child: 
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: DataTable(
          showCheckboxColumn: false,  
          columns: [
          const DataColumn(
            label: Expanded(
            child: Text(
              'Broj narudzbe',
              style: TextStyle(fontStyle: FontStyle.italic),
             ),
             ),
              ),
            const DataColumn(
            label: Expanded(
            child: Text(
              'Status narudzbe',
              style: TextStyle(fontStyle: FontStyle.italic),
             ),
             ),
              ),
              const DataColumn(
            label: Expanded(
            child: Text(
              'Datum narudzbe',
              style: TextStyle(fontStyle: FontStyle.italic),
             ),
             ),
              ),
              const DataColumn(
            label: Expanded(
            child: Text(
              'Narudzba za ponjeti',
              style: TextStyle(fontStyle: FontStyle.italic),
             ),
             ),
              ),
              const DataColumn(
            label: Expanded(
            child: Text(
              'Detaljne info',
              style: TextStyle(fontStyle: FontStyle.italic),
             ),
             ),
              ),
                ], 
                rows: resultO?.result.map((Order e)=>
          DataRow(onSelectChanged: (selected) => {
            if(selected==true)
            {
              
            }
          },
          color: WidgetStateProperty.resolveWith<Color?>(
          (Set<WidgetState> states) {
            if (e.orderStatus == 2) {
              return Colors.green.withOpacity(0.2); 
            } else if (e.orderStatus == 1) {
              return Colors.red.withOpacity(0.2); 
            }
            return null; 
          },
                ),
            cells: [
              DataCell(Text("${e.orderNumber}" ?? "")),
              DataCell(Text(
                e.orderStatus == 0
                    ? "Narudzba nije placena"
                    : e.orderStatus == 1
                        ? "Narudzba je placena"
                        : e.orderStatus == 2
                            ? "Naruzdba je gotova"
                            : "Nepoznat status",
                ),
              ),
              DataCell(Text(e.orderDate ?? "")),
              DataCell(Text(
                e.orderNullified == 0
                    ? "Narudzba za ovdje"
                    : e.orderNullified == 1
                        ? "Narudzba za ponjeti"
                        : "Nepoznat status",
                ),
              ),
              DataCell(IconButton(
              icon: Icon(Icons.info_outline),
              color: Colors.deepPurpleAccent,     
              onPressed: ()
              {
               showDialog(
                barrierDismissible: false,
                                        context: context,
                                        builder: (BuildContext context) {
                                          return FutureBuilder(
                                            future: _buildOrderDataListView(e), 
                                            builder: (context, snapshot) {
                                              if (snapshot.connectionState == ConnectionState.waiting) {
                                                return AlertDialog(
                                                  title: Text(
                                                    "Pregled jela i pića na narudzbi",
                                                    textAlign: TextAlign.center,
                                                  ),
                                                  content: Column(
                                                    mainAxisSize: MainAxisSize.min,
                                                    children: [
                                                      Text(
                                                        "Ispod vidite odabrana jela i pića za narudžbu",
                                                        textAlign: TextAlign.center,
                                                      ),
                                                      SizedBox(height: 20),
                                                      CircularProgressIndicator(), 
                                                    ],
                                                  ),
                                                );
                                              } else if (snapshot.hasError) {
                                                return AlertDialog(
                                                  title: Text("Error"),
                                                  content: Text("Something went wrong: ${snapshot.error}"),
                                                );
                                              } else if (snapshot.hasData) {
                                                return AlertDialog(
                                                  title: Text(
                                                    "Pregled jela i pića na narudzbi",
                                                    textAlign: TextAlign.center,
                                                  ),
                                                  content: Column(
                                                    mainAxisSize: MainAxisSize.min,
                                                    children: [
                                                      Text(
                                                        "Ukupna cijena je: $totalPrice KM",
                                                        textAlign: TextAlign.center,
                                                        style: TextStyle(fontWeight: FontWeight.bold,),
                                                      ),
                                                      SizedBox(height: 20),
                                                      Text(
                                                        "Ispod vidite odabrana jela i pića za narudžbu",
                                                        textAlign: TextAlign.center,
                                                      ),
                                                      SizedBox(height: 20),
                                                      Expanded(child: snapshot.data!), 
                                                    ],
                                                  ),
                                                actions: [
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                                                    children: [
                                                      SizedBox(width: 10,),
                                                      ElevatedButton(
                                                        onPressed: () {
                                                          Navigator.pop(context);
                                                        },
                                                        child: const Text("Ok"),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              );
                                            
                                            }
                                            else {
                                                return AlertDialog(
                                                  title: Text("No Data"),
                                                  content: Text("No items available."),
                                                );
                                              }
                                            }
                                          );
                                        },
                                      );
              },
            
            ),),
            ] 
          )
                ).toList() ?? []
                ),
        ),
      )
      );
  }

Future<Widget> _buildOrderDataListView(Order lastOrder) async {
  await _getDrinksAndDishes(lastOrder);
  return SingleChildScrollView(
    scrollDirection: Axis.vertical,
    child: SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Column(
        children: [
          DataTable(
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
                    'Ukupno',
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
                  ],
                );
              },
            ),
          ),
          SizedBox(height: 20,),
                  SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
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
                                                    'Ukupno',
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
                                                    DataCell(Text('$price KM')),
                                                  ],
                                                );
                                  },
                                ),
                              ),
                            ),
                          ),
        ],
      ),
    ),
  );
}

  _getDrinksAndDishes(Order lastOrder) {
    totalPrice=0.0;
    orderDishes=[];
    orderDrinks=[];
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
  }


}