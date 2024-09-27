import 'package:erestorante_mobile/models/commentDishInsert.dart';
import 'package:erestorante_mobile/providers/comment_dish_provider.dart';
import 'package:erestorante_mobile/screens/review_screen.dart';
import 'package:erestorante_mobile/utils/util.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:erestorante_mobile/models/commentStaffInsert.dart';
import 'package:erestorante_mobile/providers/comment_staff_provider.dart';
import 'package:erestorante_mobile/screens/staff_review_screen.dart';

class CommentDishScreen extends StatefulWidget {
  final TextEditingController commentController = TextEditingController();
  final int selectedUserId;

  CommentDishScreen({
    required this.selectedUserId,
  });

  @override
  _CommentDishScreenState createState() => _CommentDishScreenState();
}

class _CommentDishScreenState extends State<CommentDishScreen> {
  Color _commentColor = Colors.black;
  late CommentDishProvider _commentDishProvider;
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _commentDishProvider = context.read<CommentDishProvider>();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      FocusScope.of(context).requestFocus(_focusNode);
    });
  }

  @override
  void dispose() {
    widget.commentController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  bool validateComment(TextEditingController controller) {
    if (controller.text.isEmpty || controller.text.length > 1000) {
      setState(() {
        _commentColor = Colors.red;
      });
      return false;
    }
    setState(() {
      _commentColor = Colors.black;
    });
    return true;
  }

 @override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: Text("Recenzija Jela"),
      leading: IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => StaffReviewScreen(),
            ),
          );
        },
      ),
    ),
    body: SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "Uspješno ste recenzirali Jelo!",
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 20),
          Text(
            "Ako želite ostaviti komentar za Jelo, popunite polje za komentar i pritisnite Pošalji, ako ne želite pritisnite dugme Bez Komentara",
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 20),
          TextField(
            controller: widget.commentController,
            focusNode: _focusNode,
            decoration: InputDecoration(
              labelText: 'Komentar',
              prefixIcon: Icon(Icons.info),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              errorText: _commentColor == Colors.red
                  ? 'Komentar nije okay, mora imati min 1 slovo i max 1000'
                  : null,
            ),
            keyboardType: TextInputType.text,
            style: TextStyle(color: _commentColor),
            onSubmitted: (value) => validateComment(widget.commentController),
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () async {
                  try {
                    if (validateComment(widget.commentController)) {
                      CommentDishInsert newComment = CommentDishInsert(
                        widget.selectedUserId,
                        Info.id,
                        widget.commentController.text,
                      );
                      await _commentDishProvider.insert(newComment);
                      showDialog(
                        barrierDismissible: false,
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text(
                              "Uspješno dodan komentar za Jelo",
                              textAlign: TextAlign.center,
                            ),
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  "Uspješno ste dodali komentar za Jelo!",
                                  textAlign: TextAlign.center,
                                ),
                                SizedBox(height: 20),
                              ],
                            ),
                            actions: [
                              Center(
                                child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => ReviewScreen(),
                                      ),
                                    );
                                  },
                                  child: const Text("Ok"),
                                ),
                              ),
                            ],
                          );
                        },
                      );
                    }
                  } catch (e) {
                    showDialog(
                      barrierDismissible: false,
                      context: context,
                      builder: (BuildContext context) {
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
                            Center(
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text("Ok"),
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  }
                },
                child: const Text("Posalji"),
              ),
              SizedBox(width: 20.0),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ReviewScreen(),
                    ),
                  );
                },
                child: const Text("Bez Komentara"),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}

}