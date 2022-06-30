import 'package:flutter/material.dart';

class Input extends StatelessWidget {
  const Input({
    Key? key,
    required this.icon,
    required this.hint,
    required this.controller,
    required this.secure,
  }) : super(key: key);

  final Icon icon;
  final String hint;
  final TextEditingController controller;
  final bool secure;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: TextField(
        controller: controller,
        obscureText: secure,
        style: const TextStyle(
          fontSize: 20,
          color: Colors.grey,
        ),
        decoration: InputDecoration(
          hintStyle: const TextStyle(
              fontWeight: FontWeight.bold, fontSize: 20, color: Colors.grey),
          hintText: hint,
          focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey, width: 3)),
          enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey, width: 1)),
          prefixIcon: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: IconTheme(
              data: const IconThemeData(color: Colors.grey),
              child: icon,
            ),
          ),
        ),
      ),
    );
  }
}