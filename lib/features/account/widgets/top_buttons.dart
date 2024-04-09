import 'package:amazon_clone/features/account/widgets/account_button.dart';
import 'package:flutter/material.dart';

class TopButtons extends StatefulWidget {
  const TopButtons({super.key});

  @override
  State<TopButtons> createState() => _TopButtonsState();
}

class _TopButtonsState extends State<TopButtons> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.symmetric(vertical: 15),
          child: Row(
            children: [
              AccountButton(text: 'Your Orders', onTap: () {}),
              AccountButton(text: 'Buy Again', onTap: () {}),
            ],
          ),
        ),
        Container(
          child: Row(
            children: [
              AccountButton(text: 'Your Account', onTap: () {}),
              AccountButton(text: 'Your Lists', onTap: () {}),
            ],
          ),
        ),
      ],
    );
  }
}
