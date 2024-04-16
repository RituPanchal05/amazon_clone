import 'package:amazon_clone/constants/global_variables.dart';
import 'package:flutter/material.dart';

class customButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final Color? color;

  const customButton({super.key, required this.text, required this.onTap, this.color});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: Text(
        text,
        style: TextStyle(color: Colors.white, fontSize: 18),
      ),
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        backgroundColor: GlobalVariables.secondaryColor,
        minimumSize: const Size(double.infinity, 50), 
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
      ),
    );
  }
}
