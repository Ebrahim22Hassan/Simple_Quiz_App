import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:quiz_app/models/question_model.dart';

class DbConnect {
  final url = Uri.parse(
      'https://sample-data-3cca0-default-rtdb.firebaseio.com/questions.json');

  ///To add/post questions to database
  // Future<void> addQuestion(Question question) async {
  //   http.post(url,
  //       body: json.encode({
  //         'title': question.title,
  //         'options': question.options,
  //       }));
  // }

  ///To get/fetch questions from database
  Future<List<Question>> fetchQuestions() async {
    return http.get(url).then((response) {
      var data = json.decode(response.body) as Map<String, dynamic>;

      List<Question> newQuestions = [];
      data.forEach((key, value) {
        var newQuestion = Question(
            id: key,
            title: value['title'],
            options: Map.castFrom(value['options']));
        newQuestions.add(newQuestion);
      });

      return newQuestions;
    });
  }
}
