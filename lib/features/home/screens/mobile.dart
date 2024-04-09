import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/features/home/screens/Accessories.dart';
import 'package:amazon_clone/features/home/screens/smartPhones.dart';
import 'package:amazon_clone/features/home/widgets/top_categories.dart';
import 'package:amazon_clone/provider/user_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class mobileCatScreen extends StatefulWidget {
  static const String routeName = '/mobileCatScreen';
  final String category;
  const mobileCatScreen({super.key, required this.category});

  @override
  State<mobileCatScreen> createState() => _mobileCatScreenState();
}

class _mobileCatScreenState extends State<mobileCatScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFF84d8e2),
                  Color(0xFF92deda),
                  Color(0xFFa5e6d0),
                ],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
            ),
          ),
          title: Text(
            widget.category,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: const DefaultTabController(
        initialIndex: 0,
        length: 2,
        child: Column(
          children: [
            TabBar(
              indicatorColor: Color.fromARGB(255, 0, 131, 143),
              labelColor: Color.fromARGB(255, 0, 131, 143),
              tabs: [
                Tab(text: 'SmartPhones'),
                Tab(text: 'Accessories'),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  SmartPhoneScreen(),
                  AccessoriesScreen(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
