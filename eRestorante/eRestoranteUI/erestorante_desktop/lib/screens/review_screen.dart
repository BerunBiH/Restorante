import 'dart:convert';
import 'dart:ffi';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';

import 'package:erestorante_desktop/models/categoryC.dart';
import 'package:erestorante_desktop/models/ratingDishes.dart';
import 'package:erestorante_desktop/models/search_result.dart';
import 'package:erestorante_desktop/models/user.dart';
import 'package:erestorante_desktop/providers/category_provider.dart';
import 'package:erestorante_desktop/providers/dish_provider.dart';
import 'package:erestorante_desktop/providers/user_provider.dart';
import 'package:erestorante_desktop/screens/dishes_screen.dart';
import 'package:erestorante_desktop/utils/util.dart';
import 'package:erestorante_desktop/widgets/master_screen.dart';
import 'package:file_picker/file_picker.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:erestorante_desktop/models/dish.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:open_file/open_file.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';
import 'package:provider/provider.dart';
import 'package:fl_chart/fl_chart.dart' as charts;
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
class ReviewScreen extends StatefulWidget {
  Dish? dish;

  ReviewScreen({super.key, this.dish});

  @override
  State<ReviewScreen> createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen> {
  bool _isLoading = true;
  late UserProvider _userProvider;
  late DishProvider _dishProvider;
  SearchResult<User>? resultU;
  SearchResult<Dish>? resultDishes;
  bool _isPdfReady = false;
  File? _pdfFile;
  final GlobalKey _pieChartKey = GlobalKey();
  final GlobalKey _lineChartKey = GlobalKey();
  SearchResult<CategoryC>? result;
  late List<CategoryC> category;
  late CategoryProvider _categoryProvider;
  String? selCategory;
  bool speciality = false;
  double avgRating=0.0;
  int numRating=0;
  int numOrder=0;
  List<RatingDishes> ratingDishes = [];
  List<Dish> recommendedDishes = [];
  Dish? selectedDish;
  List<String> dates=[];
  List<double> averageReviews=[];
  double rating1=0;
  double rating2=0;
  double rating3=0;
  double rating4=0;
  double rating5=0;

  @override
  void initState() {
    super.initState();
    _userProvider = context.read<UserProvider>();
    _dishProvider = context.read<DishProvider>();
    _categoryProvider = context.read<CategoryProvider>();
    _loadData();
  }

  Future<void> _loadData() async {
    var dataU = await _userProvider.get();
    var data = await _categoryProvider.get();
    var dataDishes = await _dishProvider.get();
    var dataReco;
    if(widget.dish!=null)
    {
      dataReco= await _dishProvider.getRecommended(widget.dish!.dishID!);

    }

    setState(() {
      resultDishes = dataDishes;
      resultU = dataU;
      result = data;
      category = result!.result;
      if(widget.dish!=null)
      {
        recommendedDishes=dataReco.result;
        selectedDish=widget.dish!;
      }
      var user = resultU!.result.firstWhere((u) => u.userEmail!.contains(Authorization.email!));
      if (user.userRoles![0].role!.roleName != "Menedzer" || user.userRoles![0].role!.roleName != "Kuhar") {
        var authorised = false;
      } else {
        var authorised = true;
      }
      if(widget.dish!=null)
      {
        var catObj =category.firstWhere((x) => x.categoryId==widget.dish!.categoryId);
        selCategory=catObj.categoryName;
        speciality=widget.dish!.speciality!;

        if(widget.dish!.ratingDishes !=null && widget.dish!.ratingDishes!.isNotEmpty)
        {

          ratingDishes = widget.dish!.ratingDishes!;

          for(var date in ratingDishes)
          {
            if(!dates.contains(date.ratingDate)) {
              dates.add(date.ratingDate!);
            }
          }

          double oneRating=0.0;
          int oneNumRating=0;

          for(var date in dates)
          {
            for(var rating in ratingDishes)
            {
              if(rating.ratingDate==date)
              {
                oneRating+=rating.ratingNumber!;
                oneNumRating++;
              }
            }
            if(oneNumRating!=0)
            {
              oneRating/=oneNumRating;
              averageReviews.add(oneRating);
            }

            oneRating=0.0;
            oneNumRating=0;
          }
          
          for(var rating in widget.dish!.ratingDishes!)
          {
            avgRating+=rating.ratingNumber!;
            numRating++;

            switch (rating.ratingNumber) {
              case 1: rating1++;
              case 2: rating2++;
              case 3: rating3++;
              case 4: rating4++;
              case 5: rating5++;
                break;
              default:
            }
          }
          avgRating/=numRating;
          avgRating=double.parse(avgRating.toStringAsFixed(2));
        }

        if(widget.dish!.orderDishes !=null && widget.dish!.orderDishes!.isNotEmpty)
        {
          for(var order in widget.dish!.orderDishes!)
          {
            numOrder+=order.orderQuantity!;
          }
        }
      }
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreenWidget(
      isJelovnikPressed: false,
      isKorisniciPressed: false,
      isMojProfilPressed: false,
      isPostavkePressed: false,
      isRecenzijePressed: true,
      isRezervacijePressed: false,
      isUposleniciPressed: false,
      isOrdersPressed: false,
      child: Container(
        child: (_isLoading)
            ? Center(child: CircularProgressIndicator())
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          _buildSearch(dishes: resultDishes!.result, selectedDish: widget.dish!=null?null: selectedDish, 
                           onDishChanged: (Dish? value) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ReviewScreen(dish: value,),
                              ),
                            );
                           }
                          ),
                          Container(
                            alignment: Alignment.center,
                            child: (selectedDish != null)
                                ? _foodCardBuilder(selectedDish!)
                                : Container(
                                  height: 200,
                                  width: 400,
                                  child: Card(
                                    child: Column(
                                      children: [
                                        Text(
                                          'Dobrodošli na dio stranice za recenzije!',
                                          style: TextStyle(
                                            fontSize: 24,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                        RichText(
                                          textAlign: TextAlign.center,
                                          text: TextSpan(
                                            style: TextStyle(fontSize: 16, color: Colors.black), // Base text style
                                            children: [
                                              TextSpan(
                                                text: 'Da biste pregledali recenzije za neko jelo izaberite jelo iz liste iznad ili pritisnite ikonu ',
                                              ),
                                              WidgetSpan(
                                                child: Icon(Icons.info_outline, size: 16, color: Colors.deepPurple),
                                              ),
                                              TextSpan(
                                                text: ' Ta se ikona nalazi na jelovniku.',
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    )
                                  ),
                                ),
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

Widget _buildSearch({
  required List<Dish> dishes,
  required Dish? selectedDish,
  required Function(Dish?) onDishChanged,
}) {
  return Row(
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
                const Text("Pretražite po nazivu jela da vidite recenziju."),
                const SizedBox(height: 20.0),
                DropdownButtonFormField<Dish>(
                  value: selectedDish,
                  hint: widget.dish==null? const Text("Izaberite jelo"): Text(widget.dish!.dishName!),
                  items: dishes.map((Dish dish) {
                    return DropdownMenuItem<Dish>(
                      value: dish,
                      child: Text(dish.dishName!),
                    );
                  }).toList(),
                  onChanged: onDishChanged,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.symmetric(
                      vertical: 10.0,
                      horizontal: 10.0,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ],
  );
}



  // _foodCardBuilder function
Widget _foodCardBuilder(Dish dish) {
  return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Rounded box for dish image
          ClipRRect(
            borderRadius: BorderRadius.circular(15.0), // Adjust the radius as needed
            child: Container(
              width: 300,
              height: 150,
              color: Colors.grey[300],
              child: dish.dishImage != null && dish.dishImage!.isNotEmpty
                    ? Image.memory(
                        base64Decode(dish.dishImage!),
                        width: double.infinity,
                        height: double.infinity,
                        fit: BoxFit.cover,
                      )
                    : Image.asset(
                        'assets/images/RestoranteLogo.png',
                        width: double.infinity,
                        height: double.infinity,
                        fit: BoxFit.cover,
                      ),
            ),
          ),
          SizedBox(height: 20),
          // Dish name
          Text(
            dish.dishName ?? 'Unnamed Dish',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 5),
          // Dish description
          Text(
            dish.dishDescription ?? 'No description available',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 20,),
          Text(
            'Cijena jela je: ${dish.dishCost}KM',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 20,),
          Text(
            'Jelo: ${((speciality)? "jest specijalitet": "nije specijalitet")}',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 20,),
          Text(
            'Jelo pripada kategoriji: ${selCategory}',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 20,),
          Text(
            'Prosjecna ocjena za jelo je: ${avgRating}/5',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 20,),
          Text(
            'Jelo ima ukupno: $numRating ${(numRating==1)?'recenziju':'recenzija'}',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 20,),
          Text(
            'Jelo je ukupno ${numOrder} puta naručeno',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 20,),
          recommendedDishes.isNotEmpty? Text(
            'Uz ovo jelo, najviše su se prodavali iduća 3 jela: ${recommendedDishes[0].dishName},${recommendedDishes[1].dishName},${recommendedDishes[2].dishName}',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
            textAlign: TextAlign.center,
          ): SizedBox.shrink(),
          SizedBox(height: 20,),
          Divider(
                  indent: 400,
                  endIndent: 400,
                  thickness: 2,
                  color: Colors.black,
                ),
          Text(
            'Komentari',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
                      "Komentari za jelo ${dish.dishName} su:",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                    ),
                    SizedBox(height: 20),
                    if (dish.commentDishes != null && dish.commentDishes!.isNotEmpty)
                      Container(
                        height: 200.0,
                        width: 400.0,
                        child: Card(
                          child: SingleChildScrollView(
                            child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: dish.commentDishes!.length,
                              itemBuilder: (context, index) {
                                final commentText = dish.commentDishes![index].commentText ?? ''; 
                                return ListTile(
                                  leading: Icon(Icons.comment),
                                  title: Text(
                                    commentText,
                                    style: TextStyle(fontSize: 16),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      )
                    else
                      Text(
                        'Nema dostupnih komentara.',
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                    Divider(
                  indent: 400,
                  endIndent: 400,
                  thickness: 2,
                  color: Colors.black,
                ),
                Text(
            'Pie Chart i Line Chart za jelo',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    RepaintBoundary(
                      key: _pieChartKey,
                      child: _buildPieChart(),
                    ),
                  const VerticalDivider(
                  width: 10,
                  thickness: 2,
                  color: Colors.black,
                ),
                    RepaintBoundary(
                      key: _lineChartKey,
                      child: _buildLineChart(),
                    ),
                  ],
          ),
                             Divider(
                  indent: 400,
                  endIndent: 400,
                  thickness: 2,
                  color: Colors.black,
                ),
                Text(
            'Objašnjenje chartova',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 20.0,),
          Row(
            children: [
              Expanded(
                child: Text(
                  'Na Pie Chartu imamo prikazane ukupne ocjene na skali od 1 do 5 koje jelo ima. \n Boja koja stoji za određenu ocjenu prikazana je na legendi iznad pie charta. \n Unutar određene sekcije piše broj recenzija koje ima sa tom ocjenom. \n Ako neke boje tj. sekcije nema to znači da tu ocjenu jelo još nije dobilo. Ako je pie chart prazan, to znači da jelo nikako nije ocjenjeno.',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(width: 10), // Add some space between the texts if needed
              Expanded(
                child: Text(
                  'Na x osi su prikazani datumi kada su ostavljene recenzije, dok su na y osi prosjecne ocjene recenzija na tim datumima. \n Linija predstavlja prosjecnu ocjenu kroz vrijeme. \n Ako je graf prazan to znaci da jelo nema još recenzija.',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
          SizedBox(height: 20.0,),
                                       Divider(
                  indent: 400,
                  endIndent: 400,
                  thickness: 2,
                  color: Colors.black,
                ),
                Text(
            'Generisanje PDF-a',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                      child: Text('NAZAD NA JELOVNIK'),
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        surfaceTintColor: const Color.fromARGB(255, 255, 0, 0),
                        overlayColor: Colors.red,
                        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: _generatePdf,
                      child: Text('GENERIŠI PDF'),
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
              ),
        ],
      ),
    );
}

void _showPdfAlertDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('PDF je spreman', textAlign: TextAlign.center,),
        content: Text('Kliknite OK da spremite PDF na željenu lokaciju na računaru.', textAlign: TextAlign.center,),
        actions: <Widget>[
          Center(
            child: ElevatedButton(
              onPressed: (){
                _viewPdf();
                Navigator.of(context).pop();
              },
              child: Text('OK'),
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                overlayColor: Colors.green,
                padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
              ),
            ),
          ),
        ],
      );
    },
  );
}

void _showPDFOpenAlertDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Upss', textAlign: TextAlign.center,),
        content: Text('Desio se problem, probajte zatvoriti prvo PDF ako vam je otvoren pa onda pokušajte opet.', textAlign: TextAlign.center,),
        actions: <Widget>[
          Center(
            child: ElevatedButton(
              onPressed: (){
                Navigator.of(context).pop();
              },
              child: Text('OK'),
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                overlayColor: Colors.green,
                padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
              ),
            ),
          ),
        ],
      );
    },
  );
}

Widget _buildPieChart() {
    return Container(
      height: 500,
      width: 500,
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: SizedBox(
              height: 200,
              width: 200,
              child: PieChart(
                PieChartData(
                  sections: [
                    PieChartSectionData(
                      value: rating1,
                      title: (rating1.toInt()).toString(),
                      color: Color.fromARGB(255, 216, 7, 7),
                    ),
                    PieChartSectionData(
                      value: rating2,
                      title: (rating2.toInt()).toString(),
                      color: Color.fromARGB(255, 192, 21, 207),
                    ),
                    PieChartSectionData(
                      value: rating3,
                      title: (rating3.toInt()).toString(),
                      color: Color.fromARGB(255, 85, 93, 129),
                    ),
                    PieChartSectionData(
                      value: rating4,
                      title: (rating4.toInt()).toString(),
                      color: Color.fromARGB(255, 14, 190, 190),
                    ),
                    PieChartSectionData(
                      value: rating5,
                      title: (rating5.toInt()).toString(),
                      color: Color.fromARGB(255, 7, 185, 37),
                    ),
                  ],
                  sectionsSpace: 0,
                  centerSpaceRadius: 40,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Column(
              children: [
                Text("Ocjene koje su predstavljene bojom su:"),
                _buildLegend(),
              ],
            ),
          ),
        ],
      ),
    );
  }

Widget _buildLegend() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLegendItem('Ocjena 1', Color.fromARGB(255, 216, 7, 7)),
        _buildLegendItem('Ocjena 2', Color.fromARGB(255, 192, 21, 207)),
        _buildLegendItem('Ocjena 3', Color.fromARGB(255, 85, 93, 129)),
        _buildLegendItem('Ocjena 4', Color.fromARGB(255, 14, 190, 190)),
        _buildLegendItem('Ocjena 5', Color.fromARGB(255, 7, 185, 37)),
      ],
    );
  }

  Widget _buildLegendItem(String title, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Container(
            width: 16,
            height: 16,
            color: color,
          ),
          SizedBox(width: 8),
          Text(title),
        ],
      ),
    );
  }

Widget _buildLineChart() {
  return Container(
    width: 400, // Ensure the chart has a fixed width
    height: 200, // Ensure the chart has a fixed height
    child: LineChart(
      LineChartData(
        gridData: FlGridData(show: true),
        titlesData: FlTitlesData(
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              interval: 1,
              reservedSize: 40,
              getTitlesWidget: (value, meta) {
                // Ensure the value is valid before converting to text
                if (value.isNaN || value.isInfinite) {
                  return const Text('');  // Return an empty string for invalid values
                }
                return Text(value.toString(), style: const TextStyle(fontSize: 12));
              },
            ),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              interval: 1,
              reservedSize: 40,
              getTitlesWidget: (value, meta) {
                int index = value.toInt();

                // Defensive check: Ensure index is within the range
                if (index < 0 || index >= dates.length) {
                  return const Text('');  // Return empty string for invalid indices
                }

                DateTime? date;
                try {
                  date = DateFormat('yyyy-MM-dd').parse(dates[index]);
                } catch (e) {
                  return const Text('Invalid Date'); // Handle invalid date formats
                }

                return Text(DateFormat('dd/MM/yyyy').format(date), style: const TextStyle(fontSize: 12));
              },
            ),
          ),
        ),
        borderData: FlBorderData(show: true),
        minX: 0,
        maxX: dates.length - 1,
        minY: 0,
        maxY: 5,
        lineBarsData: [
          LineChartBarData(
            spots: List.generate(
              dates.length,
              (index) {
                final x = index.toDouble();
                final y = averageReviews[index];

                // Validate that neither x nor y is NaN or Infinity
                if (x.isNaN || x.isInfinite || y.isNaN || y.isInfinite) {
                  return FlSpot.nullSpot; // Use nullSpot for invalid data
                }

                return FlSpot(x, y);
              },
            ),
            isCurved: true,
            color: const Color.fromARGB(255, 37, 125, 197),
            barWidth: 4,
            belowBarData: BarAreaData(show: false),
          ),
        ],
      ),
    ),
  );
}



 Future<void> _generatePdf() async {
    final pdf = pw.Document();
    
    // Load the Times New Roman font
    final font = await rootBundle.load("assets/fonts/ARIAL.TTF");
    final ttf = pw.Font.ttf(font);

    // Capture the pie chart image
    final pieChartBytes = await _capturePng(_pieChartKey);
    final lineChartBytes = await _capturePng(_lineChartKey);

    // Add the dish details
    pdf.addPage(
      pw.Page(
        build: (context) => pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Text('Ime jela: ${widget.dish!.dishName}', style: pw.TextStyle(font: ttf, fontSize: 24, fontWeight: pw.FontWeight.bold)),
            pw.SizedBox(height: 8),
            pw.Text('Opis jela: ${widget.dish!.dishDescription}', style: pw.TextStyle(font: ttf, fontSize: 16)),
            pw.SizedBox(height: 8),
            pw.Text('Jelo: ${((speciality)? "jest specijalitet": "nije specijalitet")}', style: pw.TextStyle(font: ttf, fontSize: 16)),
            pw.SizedBox(height: 8),
            pw.Text('Cijena: ${widget.dish!.dishCost}KM', style: pw.TextStyle(font: ttf, fontSize: 16)),
            pw.SizedBox(height: 8),
            pw.Text('Kategorija jela: ${selCategory}', style: pw.TextStyle(font: ttf, fontSize: 16)),
            pw.SizedBox(height: 8),
            pw.Text('Broj recenzija za jelo: ${numRating}', style: pw.TextStyle(font: ttf, fontSize: 16)),
            pw.SizedBox(height: 8),
            pw.Text('Broj prosječna ocjena za jelo na skali od 1 do 5: ${avgRating}', style: pw.TextStyle(font: ttf, fontSize: 16)),
            pw.SizedBox(height: 8),
            pw.Text('Broj puta koje je jelo prodano: ${numOrder}', style: pw.TextStyle(font: ttf, fontSize: 16)),
            pw.SizedBox(height: 8),
            recommendedDishes.isNotEmpty? pw.Text('Uz ovo jelo, najviše su se prodavali iduća 3 jela: ${recommendedDishes[0].dishName},${recommendedDishes[1].dishName},${recommendedDishes[2].dishName}', style: pw.TextStyle(font: ttf, fontSize: 16)):pw.SizedBox.shrink(),
            pw.SizedBox(height: 16),
  
            // Display the dish image
            if (widget.dish!.dishImage != null && widget.dish!.dishImage!.isNotEmpty)
              pw.Center(
                child: pw.Container(
                  height: 150,
                  width: 150,
                  child: pw.Image(
                    pw.MemoryImage(base64Decode(widget.dish!.dishImage!)),
                    fit: pw.BoxFit.cover,
                  ),
                ),
              ),
            pw.SizedBox(height: 16),
            ],
        ),
      ),
    );
      pdf.addPage(
      pw.Page(
        build: (context) => pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
                        // Render Pie Chart
            pw.Text('Pie Chart', style: pw.TextStyle(font: ttf, fontSize: 16)),
            pw.Container(
              height: 200,
              child: pw.Center(
                child: pw.Image(pw.MemoryImage(pieChartBytes)),
              ),
            ),
            pw.Text('Na Pie Chartu imamo prikazane ukupne ocjene na skali od 1 do 5 koje jelo ima. \n Boja koja stoji za određenu ocjenu prikazana je na legendi iznad pie charta. \n Unutar određene sekcije piše broj recenzija koje ima sa tom ocjenom. \n Ako neke boje tj. sekcije nema to znači da tu ocjenu jelo još nije dobilo. Ako je pie chart prazan, to znači da jelo nikako nije ocjenjeno.', style: pw.TextStyle(font: ttf, fontSize: 11)),
            pw.Divider(),
             // Render Bar Chart
            pw.Text('Line Chart', style: pw.TextStyle(font: ttf, fontSize: 16)),
            pw.Container(
              height: 200,
              child: pw.Center(
                child: pw.Image(pw.MemoryImage(lineChartBytes)),
              ),
            ),
            pw.Text('Na x osi su prikazani datumi kada su ostavljene recenzije, dok su na y osi prosjecne ocjene recenzija na tim datumima. \n Linija predstavlja prosjecnu ocjenu kroz vrijeme. \n Ako je graf prazan to znaci da jelo nema još recenzija.', style: pw.TextStyle(font: ttf, fontSize: 11)),
          
          ]
        ),
      ),
      );
    final directory = await getTemporaryDirectory();
    final path = '${directory.path}/charts.pdf';
    final file = File(path);
    await file.writeAsBytes(await pdf.save());

    setState(() {
      _isPdfReady = true;
      _pdfFile = file;

      if(_isPdfReady) {
        _showPdfAlertDialog(context);
      }
    });
 }
  Future<void> _viewPdf() async {
    if (_pdfFile != null) {
      // Allow the user to select where to save the file
      String? outputFilePath = await FilePicker.platform.saveFile(
        dialogTitle: 'Save PDF to...',
        fileName: 'izvjestajZa${widget.dish!.dishName}.pdf',
        allowedExtensions: ['pdf'],
        type: FileType.custom,
      );

      if (outputFilePath != null) {
        // Copy the generated PDF to the selected location
        try{
        await _pdfFile!.copy(outputFilePath);

        // Open the saved PDF
        await OpenFile.open(outputFilePath);
        }
        catch(e){
          _showPDFOpenAlertDialog(context);
        }
      }
    }
  }
 }

    Future<Uint8List> _capturePng(GlobalKey key) async {
    try {
      RenderRepaintBoundary boundary =
          key.currentContext!.findRenderObject() as RenderRepaintBoundary;
      var image = await boundary.toImage(pixelRatio: 3.0);
      ByteData? byteData = await image.toByteData(format: ImageByteFormat.png);
      return byteData!.buffer.asUint8List();
    } catch (e) {
      throw Exception("Error capturing chart: $e");
    }
  }