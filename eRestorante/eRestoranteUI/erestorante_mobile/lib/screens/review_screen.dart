import 'dart:convert';

import 'package:erestorante_mobile/models/commentDish.dart';
import 'package:erestorante_mobile/models/dish.dart';
import 'package:erestorante_mobile/models/ratingDishes.dart';
import 'package:erestorante_mobile/models/search_result.dart';
import 'package:erestorante_mobile/providers/comment_dish_provider.dart';
import 'package:erestorante_mobile/providers/dish_provider.dart';
import 'package:erestorante_mobile/providers/rating_dish_provider.dart';
import 'package:erestorante_mobile/screens/staff_review_screen.dart';
import 'package:erestorante_mobile/utils/util.dart';
import 'package:erestorante_mobile/widgets/master_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ReviewScreen extends StatefulWidget {
  const ReviewScreen({super.key});

  @override
  State<ReviewScreen> createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen> {
  late DishProvider _dishProvider;
  SearchResult<Dish>? resultD;
  late RatingDishProvider _ratingDishProvider;
  SearchResult<RatingDishes>? resultRD;
  late CommentDishProvider _commentDishProvider;
  SearchResult<CommentDish>? resultCD;
  bool authorised = false;
  bool _isLoading = true;
  late List<ImageProvider> _dishImages;
  List<bool> _isExpandedList = [];
  List<Dish> newListDish=[];

  @override
  void initState() {
    super.initState();
    _dishProvider = context.read<DishProvider>();
    _ratingDishProvider = context.read<RatingDishProvider>();
    _commentDishProvider = context.read<CommentDishProvider>();
    _loadData();
  }

  Future<void> _loadData() async {
    var dataD = await _dishProvider.get();
    
    var dataRD = await _ratingDishProvider.get(filter: {
            'CustomerId': Info.id
          });
    
    var dataCD = await _commentDishProvider.get(filter: {
            'CustomerId': Info.id
          });

    setState(() {
      resultD = dataD;
      resultRD = dataRD;
      resultCD = dataCD;
      for(var ratingDish in resultRD!.result)
      {
        newListDish.add(resultD!.result.firstWhere((dish)=> dish.dishID== ratingDish.dishId));
      }
      _dishImages = newListDish.map((dish) {
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

      newListDish=removeDuplicates(newListDish);

      _isExpandedList = List<bool>.filled(newListDish.length, false);
      _isLoading = false;
    });
  }

  List<T> removeDuplicates<T>(List<T> inputList) {
    return inputList.toSet().toList(); 
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreenWidget(
      isJelovnikPressed: false,
      isKorpaPressed: false,
      isMojProfilPressed: false,
      isPostavkePressed: false,
      isRecenzijePressed: true,
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
                        itemCount: newListDish.length,
                        itemBuilder: (context, index) {
                          if (resultRD != null && index < newListDish.length) {
                            final dish = newListDish[index];
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
                              builder: (context) => StaffReviewScreen(),
                            ),
                          );
                        },
                        child: Text('Recenzije radnika'),
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          overlayColor: Colors.green,
                          padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
                          minimumSize: Size(120, 50),
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
                          text: 'Ispod su jela koje ste recenzirali, da biste pogledali tačne recenzije i šta ste o jelu komentarisali pritisnite ikonu:',
                        ),
                        WidgetSpan(
                          child: Icon(Icons.info_outline, size: 16, color: Colors.deepPurple),
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
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: IconButton(
                      icon: Icon(Icons.info_outline),
                      color: Colors.deepPurpleAccent,
                      alignment: Alignment.center,
                      onPressed: () {
                        _showDetailsDialog(dish);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showDetailsDialog(Dish dish){
    List<RatingDishes> ratingForDish=[];
    ratingForDish=resultRD!.result.where((rating)=> rating.dishId==dish.dishID!).toList();
    List<CommentDish> commentsForDish=[];
    commentsForDish=resultCD!.result.where((rating)=> rating.dishId==dish.dishID!).toList();
    showDialog(
      barrierDismissible: false,
      context: context, 
      builder: (BuildContext context)
    {
      return AlertDialog(
          title: Text(
            "Recenzije za odabrano jelo",
            textAlign: TextAlign.center,
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Vaše recenzije za jelo ${dish.dishName} su:",
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20),
                (ratingForDish.isNotEmpty)?
                  SizedBox(
                    height: 200.0,
                    width: double.maxFinite,
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: ratingForDish.length,
                      itemBuilder: (context, index) {
                        final ratingNumber = ratingForDish[index].ratingNumber.toString() ?? ''; 
                        final ratingDate = ratingForDish[index].ratingDate ?? ''; 
                        final ratingId = ratingForDish[index].ratingId; 
                        return ListTile(
                          leading: Icon(Icons.format_list_numbered_sharp),
                          title: Text(
                            'Ocjena jela: ${ratingNumber}',
                            style: TextStyle(fontSize: 16),
                          ),
                          subtitle: Text(
                            'Datum ocjene: ${ratingDate}',
                            style: TextStyle(fontSize: 14),
                          ),
                          trailing: IconButton(
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
                                                "Da li ste sigurni da želite izbrisati recenziju?",
                                                textAlign: TextAlign.center,
                                              ),
                                              content: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Text(
                                                    "Ako želite izbrisati recenziju pritisnite dugme ${"Izbriši"} ako ne želite, pritisnite dugme ${"Odustani"}",
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
                                                        await _ratingDishProvider.delete(ratingId!);
                                                        showDialog(
                                                          barrierDismissible: false,
                                      context: context,
                                      builder: (BuildContext context) {
                                        return StatefulBuilder(
                                          builder: (context, setState) {
                                            return AlertDialog(
                                              title: Text(
                                                "Uspješno izbrisane recenzije",
                                                textAlign: TextAlign.center,
                                              ),
                                              content: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Text(
                                                    "Uspješno ste izbrisali recenzije!",
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
                                                        Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                builder: (context) => ReviewScreen(),
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
          ),
                        );
                      },
                    ),
                  ):
                  Text(
                    'Nema dostupnih recenzija.',
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                Text(
                  "Vaši komentari za jelo ${dish.dishName} su:",
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20),
                if (commentsForDish.isNotEmpty)
                  SizedBox(
                    height: 200.0,
                    width: double.maxFinite,
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: commentsForDish.length,
                      itemBuilder: (context, index) {
                        final commentText = commentsForDish[index].commentText ?? '';
                        final commentId = commentsForDish[index].commentDishId;
                        return ListTile(
                          leading: Icon(Icons.comment),
                          title: Text(
                            commentText,
                            style: TextStyle(fontSize: 16),
                          ),
                          trailing: IconButton(
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
                                                "Da li ste sigurni da želite izbrisati komentar?",
                                                textAlign: TextAlign.center,
                                              ),
                                              content: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Text(
                                                    "Ako želite izbrisati komentar pritisnite dugme ${"Izbriši"} ako ne želite, pritisnite dugme ${"Odustani"}",
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
                                                        await _commentDishProvider.delete(commentId!);
                                                        showDialog(
                                                          barrierDismissible: false,
                                      context: context,
                                      builder: (BuildContext context) {
                                        return StatefulBuilder(
                                          builder: (context, setState) {
                                            return AlertDialog(
                                              title: Text(
                                                "Uspješno izbrisan komentar",
                                                textAlign: TextAlign.center,
                                              ),
                                              content: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Text(
                                                    "Uspješno ste izbrisali komentar!",
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
                                                        Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                builder: (context) => ReviewScreen(),
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
          ),
                        );
                      },
                    ),
                  )
                else
                  Text(
                    'Nema dostupnih komentara.',
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
              ],
            ),
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
                    padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("Ok"),
                ),
                SizedBox(width: 10),
              ],
            ),
          ],
        );
    }
    );
  }
}
