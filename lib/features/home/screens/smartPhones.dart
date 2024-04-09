import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/features/home/screens/oneplus.dart';
import 'package:amazon_clone/features/home/screens/samsung.dart';
import 'package:flutter/material.dart';

class SmartPhoneScreen extends StatefulWidget {
  const SmartPhoneScreen({super.key});

  @override
  State<SmartPhoneScreen> createState() => _SmartPhoneScreenState();
}

class _SmartPhoneScreenState extends State<SmartPhoneScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Expanded(
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemExtent: 85,
            itemCount: GlobalVariables.smartPhoneImages.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  var categories = GlobalVariables.smartPhoneImages[index]['title'];
                  print(categories);
                  switch (categories) {
                    case 'oneplus':
                      Navigator.pushNamed(context, onePlusMobile.routeName);
                      break;
                    case 'samsung':
                      Navigator.pushNamed(context, samsungMobile.routeName);
                      break;
                    default:
                  }
                },
                // navigateToCategoryPage(context, GlobalVariables.categoryImages[index]['title']!),
                child: Padding(
                  padding: const EdgeInsets.all(4),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.black12,
                          ),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: Image.asset(
                            GlobalVariables.smartPhoneImages[index]['image']!,
                            fit: BoxFit.cover,
                            height: 80,
                          ),
                        ),
                      ),
                      Text(
                        GlobalVariables.smartPhoneImages[index]['title']!,
                        style: TextStyle(fontSize: 12),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}