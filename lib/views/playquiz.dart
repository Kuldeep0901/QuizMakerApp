import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:quizmaker/models/questionmodels.dart';
import 'package:quizmaker/services/database.dart';
import 'package:quizmaker/views/result.dart';
import 'package:quizmaker/widgets/quizplaywidgets.dart';
import 'package:quizmaker/widgets/widgets.dart';

class PlayQuiz extends StatefulWidget {
  final String quizId;
  PlayQuiz(this.quizId);
  @override
  _PlayQuizState createState() => _PlayQuizState();
}

int total = 0;
int _correct = 0;
int _incorrect = 0;
int _notattempted = 0;

class _PlayQuizState extends State<PlayQuiz> {
  DatabaseService databaseService = new DatabaseService();
  QuerySnapshot questionsSnapshot;
  QuestionModel getQuestionModelFromDatasnapshot(
      DocumentSnapshot questionSnapshot) {
    QuestionModel questionModel = new QuestionModel();
    questionModel.Question = questionSnapshot.data()["question"];
    List<String> options = [
      questionSnapshot.data()["option1"],
      questionSnapshot.data()["option2"],
      questionSnapshot.data()["option3"],
      questionSnapshot.data()["option4"],
    ];
    options.shuffle();
    questionModel.option1 = options[0];
    questionModel.option2 = options[1];
    questionModel.option3 = options[2];
    questionModel.option4 = options[3];
    questionModel.correctOption = questionSnapshot.data()["option1"];
    questionModel.answered = false;
    return questionModel;
  }

  QuerySnapshot questionSnapshot;
  @override
  void initState() {
    print("${widget.quizId}");
    databaseService.getQuizData(widget.quizId).then((value) {
      questionsSnapshot = value;
      _notattempted = 0;
      _correct = 0;
      _incorrect = 0;
      total = questionsSnapshot.docs.length;
      print("$total this is total ${widget.quizId}");
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: appBar(context),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        iconTheme: IconThemeData(color: Colors.black54),
        brightness: Brightness.light,
      ),
      body: Container(
        child: Column(
          children: [
            questionsSnapshot == null
                ? Container(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  )
                : ListView.builder(
                    padding: EdgeInsets.symmetric(horizontal: 24),
                    shrinkWrap: true,
                    physics: ClampingScrollPhysics(),
                    itemCount: questionsSnapshot.docs.length,
                    itemBuilder: (context, index) {
                      return QuizPlayTile(
                        questionModel: getQuestionModelFromDatasnapshot(
                            questionsSnapshot.docs[index]),
                        index: index,
                      );
                    }),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.check),
        onPressed: () {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => Results(
                        correct: _correct,
                        incorrect: _incorrect,
                        total: total,
                      )));
        },
      ),
    );
  }
}

class QuizPlayTile extends StatefulWidget {
  final QuestionModel questionModel;
  final int index;
  QuizPlayTile({this.questionModel, this.index});
  @override
  _QuizPlayTileState createState() => _QuizPlayTileState();
}

class _QuizPlayTileState extends State<QuizPlayTile> {
  String optionSelected = "";
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Q${widget.index + 1} ${widget.questionModel.Question}",
            style: TextStyle(fontSize: 18, color: Colors.black38),
          ),
          SizedBox(
            height: 12,
          ),
          GestureDetector(
            onTap: () {
              if (!widget.questionModel.answered) {
                if (widget.questionModel.option1 ==
                    widget.questionModel.correctOption) {
                  optionSelected == widget.questionModel.Question;
                  widget.questionModel.answered = true;
                  _correct++;
                  _notattempted--;
                  setState(() {});
                } else {
                  optionSelected = widget.questionModel.correctOption;
                  widget.questionModel.answered = true;
                  _incorrect++;
                  _notattempted--;
                  setState(() {});
                }
              }
            },
            child: OptionTile(
                correctAnswer: widget.questionModel.option1,
                description: widget.questionModel.option1,
                option: "A",
                optionSelected: optionSelected),
          ),
          SizedBox(
            height: 4,
          ),
          GestureDetector(
            onTap: () {
              if (!widget.questionModel.answered) {
                if (widget.questionModel.option2 ==
                    widget.questionModel.correctOption) {
                  optionSelected == widget.questionModel.correctOption;
                  widget.questionModel.answered = true;
                  _correct++;
                  _notattempted--;
                  setState(() {});
                } else {
                  optionSelected = widget.questionModel.option2;
                  widget.questionModel.answered = true;
                  _incorrect++;
                  _notattempted--;
                  print("${widget.questionModel.correctOption}");
                  setState(() {});
                }
              }
            },
            child: OptionTile(
                correctAnswer: widget.questionModel.option2,
                description: widget.questionModel.option2,
                option: "B",
                optionSelected: optionSelected),
          ),
          SizedBox(
            height: 4,
          ),
          GestureDetector(
            onTap: () {
              if (!widget.questionModel.answered) {
                if (widget.questionModel.option3 ==
                    widget.questionModel.correctOption) {
                  optionSelected == widget.questionModel.correctOption;
                  widget.questionModel.answered = true;
                  _correct++;
                  _notattempted--;
                  setState(() {});
                } else {
                  optionSelected = widget.questionModel.option3;
                  widget.questionModel.answered = true;
                  _incorrect++;
                  _notattempted--;
                  setState(() {});
                }
              }
            },
            child: OptionTile(
                correctAnswer: widget.questionModel.option3,
                description: widget.questionModel.option3,
                option: "C",
                optionSelected: optionSelected),
          ),
          SizedBox(
            height: 4,
          ),
          GestureDetector(
            onTap: () {
              if (!widget.questionModel.answered) {
                if (widget.questionModel.option4 ==
                    widget.questionModel.correctOption) {
                  optionSelected == widget.questionModel.correctOption;
                  widget.questionModel.answered = true;
                  _correct++;
                  _notattempted--;
                  setState(() {});
                } else {
                  optionSelected = widget.questionModel.option4;
                  widget.questionModel.answered = true;
                  _incorrect++;
                  _notattempted--;
                  setState(() {});
                }
              }
            },
            child: OptionTile(
                correctAnswer: widget.questionModel.option4,
                description: widget.questionModel.option4,
                option: "D",
                optionSelected: optionSelected),
          ),
          SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
