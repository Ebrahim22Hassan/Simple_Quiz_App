import 'package:flutter/material.dart';
import 'package:quiz_app/constants.dart';

class NextButton extends StatelessWidget {
  const NextButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: neutral,
        borderRadius: BorderRadius.circular(20),
      ),
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: const Text(
        "Next Question",
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 20.0),
      ),
    );
  }
}
