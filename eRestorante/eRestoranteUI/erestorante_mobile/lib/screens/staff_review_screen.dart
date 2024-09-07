import 'dart:convert';

import 'package:cross_scroll/cross_scroll.dart';
import 'package:erestorante_mobile/models/commentDish.dart';
import 'package:erestorante_mobile/models/commentStaffInsert.dart';
import 'package:erestorante_mobile/models/commentStaffs.dart';
import 'package:erestorante_mobile/models/dish.dart';
import 'package:erestorante_mobile/models/ratingDishes.dart';
import 'package:erestorante_mobile/models/ratingStaffInsert.dart';
import 'package:erestorante_mobile/models/ratingStaffs.dart';
import 'package:erestorante_mobile/models/search_result.dart';
import 'package:erestorante_mobile/models/user.dart';
import 'package:erestorante_mobile/providers/comment_dish_provider.dart';
import 'package:erestorante_mobile/providers/comment_staff_provider.dart';
import 'package:erestorante_mobile/providers/dish_provider.dart';
import 'package:erestorante_mobile/providers/rating_dish_provider.dart';
import 'package:erestorante_mobile/providers/rating_staff_provider.dart';
import 'package:erestorante_mobile/providers/user_provider.dart';
import 'package:erestorante_mobile/screens/comment_screen.dart';
import 'package:erestorante_mobile/screens/review_screen.dart';
import 'package:erestorante_mobile/utils/util.dart';
import 'package:erestorante_mobile/widgets/master_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StaffReviewScreen extends StatefulWidget {
  final TextEditingController _commentController = TextEditingController();

  StaffReviewScreen({super.key});

  @override
  State<StaffReviewScreen> createState() => _StaffReviewScreenState();
}

class _StaffReviewScreenState extends State<StaffReviewScreen> {
  
  late RatingStaffProvider _ratingStaffProvider;
  SearchResult<RatingStaffs>? resultRS;
  late CommentStaffProvider _commentStaffProvider;
  late UserProvider _userProvider;
  SearchResult<User>? result;
  late List<User> users;
  SearchResult<CommentStaffs>? resultCS;
  bool authorised = false;
  bool _isLoading = true;
  late List<ImageProvider> _dishImages;
  String? selectedUser;
  int? selectedUserId;
  int? grade;
  Color _commentColor= Colors.black;
  late FocusNode myFocusNode;
  List<int> numbers=[1,2,3,4,5];
  List<bool> _isExpandedList = [];
  List<User> newListStaff=[];

  @override
  void initState() {
    super.initState();
    _ratingStaffProvider = context.read<RatingStaffProvider>();
    _commentStaffProvider = context.read<CommentStaffProvider>();
    _userProvider = context.read<UserProvider>();
    myFocusNode = FocusNode();
    _loadData();
  }

  Future<void> _loadData() async {
    var data = await _userProvider.get();
    
    var dataRD = await _ratingStaffProvider.get(filter: {
            'CustomerId': Info.id
          });
    
    var dataCD = await _commentStaffProvider.get(filter: {
            'CustomerId': Info.id
          });

    setState(() {
      result = data;
      resultRS = dataRD;
      resultCS = dataCD;
      users=result!.result;
      for(var ratingStaff in resultRS!.result)
      {
          newListStaff.add(result!.result.firstWhere((staff)=> ((staff.userId== ratingStaff.userId))));
      }
      newListStaff=removeDuplicates(newListStaff);

      _isExpandedList = List<bool>.filled(newListStaff.length, false);
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
      orderExists: false,
      child: (_isLoading)
          ? Center(child: CircularProgressIndicator())
          : Container(
        child:
      Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child:Column(
          children: [ 
            _buildSearch(),
            _buildDataListView(),
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
                              builder: (context) => ReviewScreen(),
                            ),
                          );
                        },
                        child: Text('Jela'),
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
                          text: 'Ispod je lista radnika koje ste recenzirali. Možete pritisnuti da vidite komentare da li ste ostavili za radnika ili ako želite da i izbrišete komentar ili recenziju.',
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

bool validateComment(TextEditingController controller1)
  {
    myFocusNode.requestFocus();
    if(controller1.text.isEmpty || controller1.text.length>1000)
    {
        setState(() {
        _commentColor = Colors.red; // Change color to red on invalid format
      });
      return false;
    }
      setState(() {
      _commentColor = Colors.black; // Reset color to black on valid input
    });
      return true;
  }


  Container _buildRegisterButton(BuildContext context) {
    return Container(
      width: 400,
      height: 100,
      child: Card(
        child: SingleChildScrollView(
            padding: const EdgeInsets.all(20.0),
            child: ElevatedButton(
                      onPressed: () {
                          showDialog(
              barrierDismissible: false,
                                        context: context,
                                        builder: (BuildContext context) {
                                          return StatefulBuilder(
                                            builder: (context, setState) {
                                              return AlertDialog(
                                                title: Text(
                                                  "Recenzirajte radnika",
                                                  textAlign: TextAlign.center,
                                                ),
                                                content: Column(
                                                  mainAxisSize: MainAxisSize.min,
                                                  children: [
                                                    Text(
                                                      "Da bi recenzirali radnika ispunite dole zadana polja:",
                                                      textAlign: TextAlign.center,
                                                    ),
                                                    SizedBox(height: 20),
                                                    Text(
                                                      "Izaberite radnika:",
                                                      textAlign: TextAlign.center,
                                                    ),
                                                    SizedBox(height: 10),
                                                    DropdownButton<int>(
                                                      value: selectedUserId,  // This should be an integer (userId)
                                                      hint: Text("Izaberite radnika"),
                                                      onChanged: (int? newValue) {
                                                        setState(() {
                                                          selectedUserId = newValue;  // Change the userId, not userName
                                                        });
                                                      },
                                                      items: users.map<DropdownMenuItem<int>>((User user) {
                                                        return DropdownMenuItem<int>(
                                                          value: user.userId,  // Use userId as the value
                                                          child: Text('${user.userName} ${user.userSurname}'),  // Display name
                                                        );
                                                      }).toList(),
                                                    ),
                                                    Text(
                                                      "Ocjenite radnika na skali od 1 do 5:",
                                                      textAlign: TextAlign.center,
                                                    ),
                                                    SizedBox(height: 10),
                                                     DropdownButton<int>(
                                                      value: grade, 
                                                      hint: Text("Izaberite ocjenu"),
                                                      onChanged: (int? newValue) {
                                                        setState(() {
                                                          grade = newValue;  
                                                        });
                                                      },
                                                      items: numbers.map<DropdownMenuItem<int>>((int number) {
                                                        return DropdownMenuItem<int>(
                                                          value: number,
                                                          child: Text(number.toString()),
                                                        );
                                                      }).toList(),
                                                    ),
                                                    
                                                ],
                                                ),
                                                actions: [
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    crossAxisAlignment: CrossAxisAlignment.center,
                                                    children: [
                                                      ElevatedButton(
                                                        onPressed: () async {
                                                          selectedUserId;
                                                          try{
                                                            RatingStaffInsert newRating= RatingStaffInsert(Info.id, selectedUserId, grade);
                                                            await _ratingStaffProvider.insert(newRating);  
                                                              Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                builder: (context) => CommentScreen(selectedUserId: selectedUserId!,),
                                                              ),
                                                            );
                                                          }
                                                          catch(e)
                                                          {
                                                              showDialog(
                                                                barrierDismissible: false,
                                                                context: context,
                                                                builder: (BuildContext context) {
                                                                  return StatefulBuilder(
                                                                    builder: (context, setState) {
                                                                      return AlertDialog(
                                                                        title: Text(
                                                                          "Upps, nešto nije okay",
                                                                          textAlign: TextAlign.center,
                                                                        ),
                                                                        content: Column(
                                                                          mainAxisSize: MainAxisSize.min,
                                                                          children: [
                                                                            Text(
                                                                              "Nešto nije okay, pokušajte ponovo!",
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
                                                                                  Navigator.pop(context);
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
                                                        },
                                                        child: const Text("Ok"),
                                                      ),
                                                      SizedBox(width: 20.0,),
                                                      ElevatedButton(
                                                        style: ElevatedButton.styleFrom(
                                                          shape: RoundedRectangleBorder(
                                                            borderRadius: BorderRadius.circular(10.0),
                                                          ),
                                                          overlayColor: Colors.red,
                                                          surfaceTintColor: const Color.fromARGB(255, 255, 0, 0),
                                                          padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
                                                        ),
                                                        onPressed: () async {
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
                      child: Text('Ocjeni Radnika'),
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        surfaceTintColor:  Colors.green,
                        overlayColor: Colors.green,
                        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
                      ),
            )
        )
      )
      );
  }
  
  Widget _buildDataListView() {
    return Expanded(
        child:CrossScroll(
        child: 
        DataTable(
        showCheckboxColumn: false,  
        columns: [
        const DataColumn(
          label: Expanded(
          child: Text(
            'Ime i Prezime',
            style: TextStyle(fontStyle: FontStyle.italic),
           ),
           ),
            ),
            const DataColumn(
          label: Expanded(
          child: Text(
            'Uloga',
            style: TextStyle(fontStyle: FontStyle.italic),
           ),
           ),
            ),
            const DataColumn(
          label: Expanded(
          child: Text(
            'Detaljno',
            style: TextStyle(fontStyle: FontStyle.italic),
           ),
           ),
            ),
      ], 
      rows: newListStaff.map((User e)=>
        DataRow(onSelectChanged: (selected) => {
          if(selected==true)
          {
            
          }
        },
          cells: [
            DataCell(Text('${e.userName} ${e.userSurname}' ?? "")),
          DataCell(
              (e.userRoles == null || e.userRoles!.isEmpty) 
                ? const Text("") 
                : Text(e.userRoles![0].role!.roleName!)
            ),
            DataCell(IconButton(
            icon: Icon(Icons.info_outline_rounded),     
            onPressed: () {
             _buildDetails(e);
},
          ),),
          ] 
        )
      ).toList() ?? []
      ),
      )
      );
  }

  void _buildDetails(User e) {
    List<RatingStaffs> ratingForUser=[];
    ratingForUser=resultRS!.result.where((rating)=> rating.userId==e.userId!).toList();
    List<CommentStaffs> commentsForUser=[];
    commentsForUser=resultCS!.result.where((rating)=> rating.userId==e.userId!).toList();
    showDialog(
      barrierDismissible: false,
      context: context, 
      builder: (BuildContext context)
    {
      return AlertDialog(
          title: Text(
            "Recenzije za odabranog radnika",
            textAlign: TextAlign.center,
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Vaše recenzije za radnika ${e.userName} su:",
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20),
                (ratingForUser.isNotEmpty)?
                  SizedBox(
                    height: 200.0,
                    width: double.maxFinite,
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: ratingForUser.length,
                      itemBuilder: (context, index) {
                        final ratingNumber = ratingForUser[index].ratingNumber.toString() ?? ''; 
                        final ratingDate = ratingForUser[index].ratingDate ?? ''; 
                        final ratingId = ratingForUser[index].ratingStaffId; 
                        return ListTile(
                          leading: Icon(Icons.format_list_numbered_sharp),
                          title: Text(
                            'Ocjena osoblja: ${ratingNumber}',
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
                                                        await _ratingStaffProvider.delete(ratingId!);
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
                                                                builder: (context) => StaffReviewScreen(),
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
                  "Vaši komentari za radnika ${e.userName} su:",
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20),
                if (commentsForUser.isNotEmpty)
                  SizedBox(
                    height: 200.0,
                    width: double.maxFinite,
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: commentsForUser.length,
                      itemBuilder: (context, index) {
                        final commentText = commentsForUser[index].commentText ?? '';
                        final commentId = commentsForUser[index].commentStaffId;
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
                                                        await _commentStaffProvider.delete(commentId!);
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
                                                                builder: (context) => StaffReviewScreen(),
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

  Widget _buildTextField({
    required TextEditingController controller,
    required String labelText,
    int? maxLength,
  }) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(labelText: labelText),
      maxLength: maxLength,
    );
  }
}
