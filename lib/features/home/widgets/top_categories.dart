import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/features/home/screens/category_deals_screen.dart';
import 'package:amazon_clone/features/home/screens/mobile.dart';
import 'package:flutter/material.dart';

class topCategories extends StatelessWidget {
  const topCategories({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      child: Expanded(
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemExtent: 85,
          itemCount: GlobalVariables.categoryImages.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                var categories = GlobalVariables.categoryImages[index]['title'];
                switch (categories) {
                  case 'Mobiles':
                    Navigator.pushNamed(context, mobileCatScreen.routeName, arguments: categories);
                    break;
                  case 'Fashion':
                    Navigator.pushNamed(context, mobileCatScreen.routeName, arguments: categories);
                    break;
                  default:
                }
              },
              // navigateToCategoryPage(context, GlobalVariables.categoryImages[index]['title']!),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: Image.asset(
                        GlobalVariables.categoryImages[index]['image']!,
                        fit: BoxFit.cover,
                        height: 50,
                        width: 50,
                      ),
                    ),
                  ),
                  Text(
                    GlobalVariables.categoryImages[index]['title']!,
                    style: TextStyle(fontSize: 12),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
