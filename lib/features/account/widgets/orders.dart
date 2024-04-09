import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/features/account/widgets/single_product.dart';
import 'package:flutter/material.dart';

class Orders extends StatefulWidget {
  const Orders({super.key});

  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  List list = [
    'https://unsplash.com/photos/black-and-red-corded-computer-mouse-j4PqlNVZ4Bc',
    'https://unsplash.com/photos/white-and-grey-logitech-g-series-cordless-mouse-on-white-surface-VghbBAYqUJ0',
    'https://unsplash.com/photos/white-and-grey-logitech-g-series-cordless-mouse-on-white-surface-VghbBAYqUJ0',
    'https://unsplash.com/photos/white-and-grey-logitech-g-series-cordless-mouse-on-white-surface-VghbBAYqUJ0',
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: const EdgeInsets.only(left: 15),
              child: const Text(
                "Your Orders",
                style: TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.w600),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(right: 15),
              child: Text(
                "See sll",
                style: TextStyle(fontSize: 16, color: GlobalVariables.selectedNavBarColor, fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
        Container(
          height: 170,
          padding: const EdgeInsets.only(
            left: 10,
            top: 20,
            right: 0,
          ),
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: list.length,
            itemBuilder: (context, index) {
              return singleProduct(image: list[index]);
            },
          ),
        ),
      ],
    );
  }
}
