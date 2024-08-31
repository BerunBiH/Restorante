import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';

import 'package:erestorante_desktop/models/categoryC.dart';
import 'package:erestorante_desktop/models/search_result.dart';
import 'package:erestorante_desktop/models/user.dart';
import 'package:erestorante_desktop/providers/category_provider.dart';
import 'package:erestorante_desktop/providers/dish_provider.dart';
import 'package:erestorante_desktop/providers/user_provider.dart';
import 'package:erestorante_desktop/utils/util.dart';
import 'package:erestorante_desktop/widgets/master_screen.dart';
import 'package:file_picker/file_picker.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:erestorante_desktop/models/dish.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
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
  SearchResult<Dish>? resultD;
  bool _isPdfReady = false;
  File? _pdfFile;
  final GlobalKey _pieChartKey = GlobalKey();
  final GlobalKey _barChartKey = GlobalKey();
  SearchResult<CategoryC>? result;
  late List<CategoryC> category;
  late CategoryProvider _categoryProvider;
  String? selCategory;

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
    var dataD = await _dishProvider.get();
    var data = await _categoryProvider.get();

    setState(() {
      resultU = dataU;
      resultD = dataD;
      result = data;
      category = result!.result;
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
      child: Container(
        child: (_isLoading)
            ? Center(child: CircularProgressIndicator())
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    alignment: Alignment.center,
                    child: (widget.dish != null)
                        ? _foodCardBuilder(widget.dish!)
                        : Text("Nema jela"),
                  ),
                ],
              ),
      ),
    );
  }

  // _foodCardBuilder function
Widget _foodCardBuilder(Dish dish) {
  return Column(
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
                if (dish.CommentDishes != null && dish.CommentDishes!.isNotEmpty)
                  SizedBox(
                    height: 200.0,
                    width: double.maxFinite,
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: dish.CommentDishes!.length,
                      itemBuilder: (context, index) {
                        final commentText = dish.CommentDishes![index].commentText ?? ''; 
                        return ListTile(
                          leading: Icon(Icons.comment),
                          title: Text(
                            commentText,
                            style: TextStyle(fontSize: 16),
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
      Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                RepaintBoundary(
                  key: _pieChartKey,
                  child: _buildPieChart(),
                ),
                VerticalDivider(thickness: 2),
                // RepaintBoundary(
                //   key: _barChartKey,
                //   child: _buildBarChart(),
                // ),
              ],
      ),
      Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('NAZAD'),
                  style: ElevatedButton.styleFrom(foregroundColor: Colors.grey),
                ),
                ElevatedButton(
                  onPressed: _generatePdf,
                  child: Text('PREUZMI'),
                  style: ElevatedButton.styleFrom(foregroundColor: Colors.grey),
                ),
              ],
            ),
          ),
          if (_isPdfReady) 
            TextButton(
              onPressed: _viewPdf,
              child: Text('PDF je spreman. Kliknite za pregled.'),
            ),
    ],
  );
}
Widget _buildPieChart() {
    return SizedBox(
      height: 200,
      width: 200,
      child: PieChart(
        PieChartData(
          sections: [
            PieChartSectionData(
              value: 5,
              title: 'Sektor 1',
              color: Colors.greenAccent,
            ),
            PieChartSectionData(
              value: 3,
              title: 'Sektor 2',
              color: Colors.lightGreen,
            ),
            PieChartSectionData(
              value: 2,
              title: 'Sektor 3',
              color: Colors.green,
            ),
          ],
          sectionsSpace: 0,
          centerSpaceRadius: 40,
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
    // final barChartBytes = await _capturePng(_barChartKey);

    print("we are here");

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
            pw.Text('Jelo: ${((widget.dish!.speciality!)? "jest specijalitet": "nije specijalitet")}', style: pw.TextStyle(font: ttf, fontSize: 16)),
            pw.SizedBox(height: 8),
            pw.Text('Cijena: ${widget.dish!.dishCost}KM', style: pw.TextStyle(font: ttf, fontSize: 16)),
            pw.SizedBox(height: 8),
            pw.Text('Kategorija jela: ${selCategory}', style: pw.TextStyle(font: ttf, fontSize: 16)),
            pw.SizedBox(height: 8),
            pw.Text('Broj puta koje je jelo prodano: 111', style: pw.TextStyle(font: ttf, fontSize: 16)),
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

            // Render Pie Chart
            pw.Text('Pie Chart', style: pw.TextStyle(font: ttf, fontSize: 16)),
            pw.Container(
              height: 200,
              child: pw.Center(
                child: pw.Image(pw.MemoryImage(pieChartBytes)),
              ),
            ),
            pw.Divider(),

            // Render Bar Chart
            // pw.Text('Bar Chart', style: pw.TextStyle(font: ttf, fontSize: 16)),
            // pw.Container(
            //   height: 200,
            //   child: pw.Center(
            //     child: pw.Image(pw.MemoryImage(barChartBytes)),
            //   ),
            // ),
          ],
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
        await _pdfFile!.copy(outputFilePath);

        // Open the saved PDF
        await OpenFile.open(outputFilePath);
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