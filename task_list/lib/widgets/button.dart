import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  const Button({Key? key, required this.text, required this.handler})
      : super(key: key);

  final String text;
  final Function() handler;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: handler,
        child: Text(
          text,
          style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.grey[300],
              fontSize: 20),
        ));
  }
}