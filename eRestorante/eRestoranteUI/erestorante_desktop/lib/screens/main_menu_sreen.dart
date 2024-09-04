import 'dart:convert';

import 'package:erestorante_desktop/models/dish.dart';
import 'package:erestorante_desktop/models/search_result.dart';
import 'package:erestorante_desktop/providers/dish_provider.dart';
import 'package:erestorante_desktop/screens/dish_add_screen.dart';
import 'package:erestorante_desktop/widgets/master_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainMenuSreen extends StatefulWidget {
  const MainMenuSreen({super.key});

  @override
  State<MainMenuSreen> createState() => _MainMenuSreenState();
}

class _MainMenuSreenState extends State<MainMenuSreen> {
  final PageController _pageController = PageController();
  late DishProvider _dishProvider;
  SearchResult<Dish>? resultD;
  late List<Dish> allDishes;
  late List<Dish> dishes;
  int _currentIndex = 0;
  bool _isLoading = true;
  bool _hasItems = true;
  late List<ImageProvider> _dishImages;

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
      allDishes=resultD!.result;
      var newList=allDishes.where((x)=> x.speciality==true).toList();
      if(newList.length==0)
      {
        _hasItems=false;
        dishes=[];
      }
      else
        dishes=newList;
      _isLoading = false;

      _dishImages = dishes.map((dish) {
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
    });
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
      child:(_isLoading) ?
      Center(child: CircularProgressIndicator()):
      SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 400,
              child:
                !_hasItems?
                Scaffold(
                  body: Stack(
                    children: [
                      _dishesNotFoundBuilder(1),
                    ],
                  ),
                ):
                Scaffold(
                body: Stack(
                    children: [
                      PageView.builder(
                        controller: _pageController,
                        itemCount: dishes.length,
                        onPageChanged: (index) {
                          setState(() {
                            _currentIndex = index;
                          });
                        },
                        itemBuilder: (context, index) 
                        {
                          return _mainMethodeBuilder(index);
                        },
                      ),
                      // Left Arrow
                      _leftArrow(context),
                      // Right Arrow
                      _rightArrow(context),
                      // Indicator Dots
                      _indicatorDots(),
                    ],
                  ),
                 ),
            ),
            SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                  Container(
                    width: 1000,
                    child: Card(
                      child: SingleChildScrollView(
                          padding: const EdgeInsets.all(20.0),
              child: Column(
              children: [
                                
                                const SizedBox(height: 20.0),
                                const Text("Ako želite dodati novo jelo, idite do jelovnika, dok za pregled jela idite na Recenzije. Uposlenicima upravljate pomoću uposlenici tab-a, isto važi i za rezervacije i korisinike. Vašim profilom upravljate tako što koristite lijevi slide-bar.",
                                                style: TextStyle(
                    fontSize: 15.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.center,
                                ),
                    
              const SizedBox(height: 20.0),
              const Text("Uživajte u Restorante!",
              style: TextStyle(
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold,
                    color: Color.fromRGBO(111, 63, 189, 0.612),
                  ),
                  textAlign: TextAlign.center,
                                ),
                    
              const SizedBox(height: 20.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                  ),
                const SizedBox(height: 5.0),
              ],
            ),
                      )
                    )
                  ),
                ],
                ),
              ],
            ),
      ),
      );
  }

  Positioned _indicatorDots() {
    return Positioned(
            bottom: 20,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(dishes.length, (index) {
                return AnimatedContainer(
                  duration: Duration(milliseconds: 300),
                  margin: EdgeInsets.symmetric(horizontal: 4.0),
                  height: 12.0,
                  width: _currentIndex == index ? 12.0 : 8.0,
                  decoration: BoxDecoration(
                    color: _currentIndex == index ? Colors.white : Colors.white.withOpacity(0.5),
                    shape: BoxShape.circle,
                  ),
                );
              }),
            ),
          );
  }

  Positioned _rightArrow(BuildContext context) {
    return Positioned(
            right: 10,
            top: 200,
            child: IconButton(
              icon: Icon(Icons.arrow_forward_ios, color: Colors.white),
              onPressed: _nextPage,
            ),
          );
  }

  Positioned _leftArrow(BuildContext context) {
    return Positioned(
            left: 10,
            top: 200,
            child: IconButton(
              icon: Icon(Icons.arrow_back_ios, color: Colors.white),
              onPressed: _previousPage,
            ),
          );
  }

 void _nextPage() {
    if (_currentIndex < dishes.length - 1) {
      _pageController.nextPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    }
  }

  void _previousPage() {
    if (_currentIndex > 0) {
      _pageController.previousPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    }
  }

Stack _dishesNotFoundBuilder(int index) {
    return Stack(
      children: <Widget>[
        // Background Image
        Positioned.fill(
          child: Image.asset(
                  'assets/images/RestoranteLogo.png',
                  width: double.infinity,
                  height: double.infinity,
                  fit: BoxFit.cover,
                ),
        ),
        // Semi-transparent Overlay
        Positioned.fill(
          child: Container(
            color: Colors.black.withOpacity(0.5),
          ),
        ),
        // Content Overlay
        Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                'UPSSS',
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white.withOpacity(0.7),
                ),
              ),
              SizedBox(height: 8.0),
              Text(
                "Trenutno nema specijaliteta :(",
                style: TextStyle(
                  fontSize: 36.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 16.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32.0),
                child: Text(
                  "Pritisni dugme da dodaš novo jelo koje može biti specijalitet",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.white.withOpacity(0.7),
                  ),
                ),
              ),
              SizedBox(height: 24.0),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DishAddScreen(backMain: true),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 32.0, vertical: 12.0),
                ),
                child: Text('DODAJ JELO'),
              ),
            ],
          ),
        ),
      ],
    );
  }

Stack _mainMethodeBuilder(int index) {
    return Stack(
      children: <Widget>[
        // Background Image
        Positioned.fill(
          child: Image(
            image: _dishImages[index],
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,
          ),
        ),
        // Semi-transparent Overlay
        Positioned.fill(
          child: Container(
            color: Colors.black.withOpacity(0.5),
          ),
        ),
        // Content Overlay
        Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                'SPECIJALITETI',
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white.withOpacity(0.7),
                ),
              ),
              SizedBox(height: 8.0),
              Text(
                dishes[index].dishName!,
                style: TextStyle(
                  fontSize: 36.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 16.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32.0),
                child: Text(
                  dishes[index].dishDescription!,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.white.withOpacity(0.7),
                  ),
                ),
              ),
              SizedBox(height: 24.0),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DishAddScreen(dish: dishes[index], backMain: true,),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 32.0, vertical: 12.0),
                ),
                child: Text('PREPRAVI JELO'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}