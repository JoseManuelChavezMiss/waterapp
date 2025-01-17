import 'package:flutter/material.dart';
import 'package:waterapp/Components/Colors/colorBlue.dart';

class Button extends StatelessWidget {
  const Button({super.key, required this.label, required this.press});

  final String label;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      width: size.width * 0.8,
      height: 50,
      decoration: BoxDecoration(
        color: colorBlue,
        borderRadius: BorderRadius.circular(20),
      ),
      child: TextButton(
        onPressed: press,
        child: Text(label, style: const TextStyle(color: Colors.white)),
      ),
    );
  }
}
