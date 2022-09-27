import 'package:flutter/material.dart';
import 'package:quiz_app/constants.dart';

class ResultBox extends StatelessWidget {
  const ResultBox(
      {Key? key,
      required this.result,
      required this.questionLength,
      required this.onTap})
      : super(key: key);

  final int result;
  final int questionLength;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: background,
      content: Padding(
        padding: const EdgeInsets.all(60.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              "Result",
              style: TextStyle(
                color: neutral,
                fontSize: 24.0,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            CircleAvatar(
              radius: 60.0,
              backgroundColor: result == questionLength / 2
                  ? Colors.yellow
                  : result < questionLength / 2
                      ? incorrect
                      : correct,
              child: Text(
                "$result/$questionLength",
                style: const TextStyle(
                  fontSize: 50,
                ),
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            Text(
              result == questionLength / 2
                  ? "Almost there"
                  : result < questionLength / 2
                      ? "Try Again"
                      : "Great!",
              style: const TextStyle(
                fontSize: 30.0,
                color: neutral,
              ),
            ),
            const SizedBox(
              height: 25.0,
            ),
            GestureDetector(
              onTap: onTap,
              child: const Text(
                "Start Over",
                style: TextStyle(
                  fontSize: 20.0,
                  letterSpacing: 2.0,
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
