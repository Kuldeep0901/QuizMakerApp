import 'package:flutter/material.dart';
import 'package:quizmaker/services/database.dart';
import 'package:quizmaker/views/addquestion.dart';
import 'package:quizmaker/widgets/widgets.dart';
import 'package:random_string/random_string.dart';

class CreateQuiz extends StatefulWidget {
  @override
  _CreateQuizState createState() => _CreateQuizState();
}

class _CreateQuizState extends State<CreateQuiz> {
  final _formkey = GlobalKey<FormState>();
  String quizImageUrl, quizTitle, quizdescription, quizid;
  DatabaseService databaseService = new DatabaseService();
  bool _isLoading = false;

  createQuizOnline() async {
    if (_formkey.currentState.validate()) {
      setState(() {
        _isLoading = true;
      });
      quizid = randomAlphaNumeric(16);
      Map<String, String> quizMap = {
        "quizId": quizid,
        "quizImgurl": quizImageUrl,
        "quiztitle": quizTitle,
        "quizDesc": quizdescription,
      };
      await databaseService.addQuizData(quizMap, quizid).then((value) {
        setState(() {
          _isLoading = false;
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => AddQuestion(quizid)));
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
                          val.isEmpty ? "Enter Image Url" : null,
                      decoration: InputDecoration(
                        hintText: "Quiz Image Url",
                      ),
                      onChanged: (val) {
                        quizImageUrl = val;
                      },
                    ),
                    SizedBox(
                      height: 6,
                    ),
                    TextFormField(
                      validator: (val) => val.isEmpty ? "Enter Title" : null,
                      decoration: InputDecoration(
                        hintText: "Quiz Title",
                      ),
                      onChanged: (val) {
                        quizTitle = val;
                      },
                    ),
                    SizedBox(
                      height: 6,
                    ),
                    TextFormField(
                      validator: (val) =>
                          val.isEmpty ? "Enter description" : null,
                      decoration: InputDecoration(
                        hintText: "QuizDescription",
                      ),
                      onChanged: (val) {
                        quizdescription = val;
                      },
                    ),
                    Spacer(),
                    GestureDetector(
                      onTap: () {
                        createQuizOnline();
                      },
                      child: blueButton(context: context, label: "Create Quiz"),
                    ),
                    SizedBox(
                      height: 6,
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
