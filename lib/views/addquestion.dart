import 'package:flutter/material.dart';
import 'package:quizmaker/services/database.dart';
import 'package:quizmaker/widgets/widgets.dart';

class AddQuestion extends StatefulWidget {
  final String quizId;
  AddQuestion(this.quizId);
  @override
  _AddQuestionState createState() => _AddQuestionState();
}

class _AddQuestionState extends State<AddQuestion> {
  final _formkey = GlobalKey<FormState>();
  String question, option1, option2, option3, option4;
  bool _isLoading = false;

  DatabaseService databaseService = new DatabaseService();

  uploadQuestionData() {
    if (_formkey.currentState.validate()) {
      setState(() {
        _isLoading = true;
      });
      Map<String, String> questionMap = {
        "question": question,
        "option1": option1,
        "option2": option2,
        "option3": option3,
        "option4": option4,
      };
      databaseService.addQuestionData(questionMap, widget.quizId).then((value) {
        setState(() {
          _isLoading = false;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: appBar(context),
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          iconTheme: IconThemeData(color: Colors.black26),
          brightness: Brightness.light,
        ),
        body: _isLoading
            ? Container(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              )
            : Form(
                key: _formkey,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    children: [
                      TextFormField(
                        validator: (val) =>
                            val.isEmpty ? "Enter Question" : null,
                        decoration: InputDecoration(
                          hintText: "Question",
                        ),
                        onChanged: (val) {
                          question = val;
                        },
                      ),
                      SizedBox(
                        height: 6,
                      ),
                      TextFormField(
                        validator: (val) =>
                            val.isEmpty ? "Enter option1" : null,
                        decoration: InputDecoration(
                          hintText: "option1",
                        ),
                        onChanged: (val) {
                          option1 = val;
                        },
                      ),
                      SizedBox(
                        height: 6,
                      ),
                      TextFormField(
                        validator: (val) =>
                            val.isEmpty ? "Enter option2" : null,
                        decoration: InputDecoration(
                          hintText: "option2",
                        ),
                        onChanged: (val) {
                          option2 = val;
                        },
                      ),
                      SizedBox(
                        height: 6,
                      ),
                      TextFormField(
                        validator: (val) =>
                            val.isEmpty ? "Enter option3" : null,
                        decoration: InputDecoration(
                          hintText: "option3",
                        ),
                        onChanged: (val) {
                          option3 = val;
                        },
                      ),
                      SizedBox(
                        height: 6,
                      ),
                      TextFormField(
                        validator: (val) =>
                            val.isEmpty ? "Enter option4" : null,
                        decoration: InputDecoration(
                          hintText: "option4",
                        ),
                        onChanged: (val) {
                          option4 = val;
                        },
                      ),
                      Spacer(),
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: blueButton(
                                context: context,
                                label: "Submit",
                                buttonWidth:
                                    MediaQuery.of(context).size.width / 2 - 36),
                          ),
                          SizedBox(
                            width: 24,
                          ),
                          GestureDetector(
                            onTap: () {
                              uploadQuestionData();
                            },
                            child: blueButton(
                                context: context,
                                label: "Add Question",
                                buttonWidth:
                                    MediaQuery.of(context).size.width / 2 - 36),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 60,
                      ),
                    ],
                  ),
                ),
              ));
  }
}
