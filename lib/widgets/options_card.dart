import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';

class OptionsCard extends StatelessWidget {
  const OptionsCard({
    Key? key,
    required this.option,
    required this.color,
    required this.neumorphism,
  }) : super(key: key);

  final String option;
  final Color color;
  //final Color textColor;
  final bool neumorphism;
  @override
  Widget build(BuildContext context) {
    //bool neumorphism = true;
    Offset distance = neumorphism ? const Offset(5, -5) : const Offset(-4, 4);
    double blur = neumorphism ? 5.0 : 30.0;
    return Column(
      children: [
        Card(
          color: color,
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.0),
                color: color,
                boxShadow: [
                  BoxShadow(
                    offset: -distance,
                    color: const Color(0xffffc412),
                    blurRadius: blur,
                    inset: neumorphism,
                  ),
                  BoxShadow(
                    offset: distance,
                    color: const Color(0xff763e06),
                    blurRadius: blur,
                    inset: neumorphism,
                  ),
                ]),
            child: ListTile(
              minVerticalPadding: 25,
              title: Text(
                option,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 22,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 25,
        ),
      ],
    );
  }
}
