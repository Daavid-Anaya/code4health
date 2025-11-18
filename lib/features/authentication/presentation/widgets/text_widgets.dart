import 'package:flutter/material.dart';

class TextWidgets extends StatelessWidget {
  final String title;
  final TextStyle stylee;

  const TextWidgets({super.key, required this.title, required this.stylee });

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      textAlign: TextAlign.center,
      style: stylee,
    );
  }
}
