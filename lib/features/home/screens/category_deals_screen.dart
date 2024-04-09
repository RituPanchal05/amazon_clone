import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/provider/user_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CategoryDealsScreen extends StatefulWidget {
  static const String routeName = '/categoryDealsScreen';
  final String category;
  const CategoryDealsScreen({super.key, required this.category});

  @override
  State<CategoryDealsScreen> createState() => _CategoryDealsScreenState();
}

class _CategoryDealsScreenState extends State<CategoryDealsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: PreferredSize(
        //   preferredSize: const Size.fromHeight(50),
        //   child: AppBar(
        //     flexibleSpace: Container(
        //       decoration: const BoxDecoration(
        //         gradient: LinearGradient(
        //           colors: [
        //             Color(0xFF84d8e2),
        //             Color(0xFF92deda),
        //             Color(0xFFa5e6d0),
        //           ],
        //           begin: Alignment.centerLeft,
        //           end: Alignment.centerRight,
        //         ),
        //       ),
        //     ),
        //     title: Text(
        //       widget.category,
        //       style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        //     ),
        //   ),
        // ),
        // body: Column(
        //   children: [
        //     Container(
        //       padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        //       alignment: Alignment.topLeft,
        //       child: Text(
        //         'Keep shopping for ${widget.category}',
        //         style: TextStyle(
        //           fontSize: 20,
        //         ),
        //       ),
        //     ),
        //   ],
        // ),
        );
  }
}
