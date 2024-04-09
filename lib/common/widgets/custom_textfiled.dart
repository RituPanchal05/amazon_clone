// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class customTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obSecureChar;
  final int maxLines;

  const customTextField({super.key, required this.controller, required this.hintText, required this.obSecureChar, this.maxLines = 1});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obSecureChar,
      obscuringCharacter: '*',
      decoration: InputDecoration(
        hintText: hintText,
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black38),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black38),
        ),
      ),
      validator: (val) {
        if (val == null || val.isEmpty) {
          return 'Enter your $hintText';
        }
        return null;
      },
      maxLines: maxLines,
    );
  }
}
