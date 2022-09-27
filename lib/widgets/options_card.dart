import 'package:flutter/material.dart';

class OptionsCard extends StatelessWidget {
  const OptionsCard({
    Key? key,
    required this.option,
    required this.color,
  }) : super(key: key);

  final String option;
  final Color color;
  //final Color textColor;
  @override
  Widget build(BuildContext context) {
    return Card(
      color: color,
      child: ListTile(
        title: Text(
          option,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 22,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
