import 'package:flutter/material.dart';
import 'package:quiz_app/constants.dart';
import 'package:quiz_app/models/question_model.dart';
import 'package:quiz_app/widgets/next_button.dart';
import 'package:quiz_app/widgets/options_card.dart';
import 'package:quiz_app/widgets/question_widget.dart';
import 'package:quiz_app/widgets/result_box.dart';

import '../models/db_connect.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ///get Questions from database
  var db = DbConnect();
  late Future _questions;

  Future<List<Question>> getData() async {
    return db.fetchQuestions();
  }

  @override
  void initState() {
    _questions = getData();
    super.initState();
  }

  ///list of local questions
  // final List<Question> _questions = [
  //   Question(
  //       id: '1',
  //       title: "what is 2+4",
  //       options: {'5': false, '6': true, '4': false, '11': false}),
  //   Question(
  //       id: '2',
  //       title: "what is 4+4",
  //       options: {'5': false, '8': true, '4': false, '7': false}),
  //   Question(
  //       id: '3',
  //       title: "what is 5+4",
  //       options: {'5': false, '9': true, '4': false, '20': false}),
  // ];

  int index = 0; // index to loop through Questions
  int score = 0; // Score variable
  bool isPressed = false; // check if the user click any answer

  /// Function to display the next Question
  bool isAlreadySelected = false;

  void nextQuestion(int questionLength) {
    if (index == questionLength - 1) {
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) => ResultBox(
            result: score, questionLength: questionLength, onTap: startOver),
      );
    } else {
      if (isPressed) {
        setState(() {
          index++;
          isPressed = false;
          isAlreadySelected = false;
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Please select any answer !!"),
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.symmetric(vertical: 20),
        ));
      }
    }
  }

  /// Function for changing cards color
  void checkAnswerAndUpdate(bool value) {
    if (isAlreadySelected) {
      return;
    } else {
      if (value == true) {
        score++;
      }
      setState(() {
        isPressed = true;
        isAlreadySelected = true;
      });
    }
  }

  /// Function to Start Over
  void startOver() {
    setState(() {
      index = 0;
      score = 0;
      isPressed = false;
      isAlreadySelected = false;
    });
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _questions as Future<List<Question>>,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            return Center(child: Text('${snapshot.error}'));
          } else if (snapshot.hasData) {
            ///
            var extractedData =
                snapshot.data as List<Question>; // important note
            return Scaffold(
              backgroundColor: background,
              appBar: AppBar(
                backgroundColor: background,
                centerTitle: true,
                title: const Text("Quiz App"),
                //shadowColor: Colors.transparent,
                actions: [
                  Padding(
                    padding: const EdgeInsets.all(17.0),
                    child: Text(
                      "Score: $score",
                      style: const TextStyle(fontSize: 17.0),
                    ),
                  ),
                ],
              ),
              body: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      background,
                      gradient,
                    ],
                  ),
                ),
                padding: const EdgeInsets.all(40),
                width: double.infinity,
                child: Column(
                  children: [
                    QuestionWidget(
                      indexAction: index,
                      question: extractedData[index].title,
                      totalQuestions: extractedData.length,
                    ),
                    const Divider(
                      color: neutral,
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    for (int i = 0;
                        i < extractedData[index].options.length;
                        i++)
                      GestureDetector(
                        child: OptionsCard(
                          option: extractedData[index].options.keys.toList()[i],
                          color: isPressed
                              ? extractedData[index]
                                          .options
                                          .values
                                          .toList()[i] ==
                                      true
                                  ? correct
                                  : incorrect
                              : cardColor,
                        ),
                        onTap: () {
                          checkAnswerAndUpdate(
                              extractedData[index].options.values.toList()[i]);
                        },
                      ),
                  ],
                ),
              ),
              floatingActionButton: GestureDetector(
                onTap: () {
                  nextQuestion(extractedData.length);
                },
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  child: NextButton(),
                ),
              ),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerFloat,
            );
          } else {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                CircularProgressIndicator(),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Waiting",
                  style: TextStyle(
                      fontSize: 18,
                      decoration: TextDecoration.none,
                      color: neutral),
                ),
              ],
            );
          }
        }
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            CircularProgressIndicator(),
            SizedBox(
              height: 20,
            ),
            Text(
              "Waiting",
              style: TextStyle(
                fontSize: 18,
                decoration: TextDecoration.none,
                color: neutral,
              ),
            ),
          ],
        );
        //const Center(child: Text("No Data"));
      },
    );
  }
}
