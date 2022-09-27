import 'package:flutter/material.dart';
import 'package:quiz_app/screens/home_screen.dart';

void main() {
  // var db = DbConnect();
  ///add question to db
  // db.addQuestion(
  //   Question(
  //       id: '1',
  //       title: "what is 2+4",
  //       options: {'5': false, '6': true, '4': false, '11': false}),
  // );
  ///get question from db
  //db.fetchQuestions();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Quiz App',
      home: HomeScreen(),
    );
  }
}
