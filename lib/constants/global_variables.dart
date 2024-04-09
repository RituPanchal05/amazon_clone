import 'package:flutter/material.dart';

//!For real device
// String uri = "http://192.168.1.7:3000";

//!For real device
// String uri1 = "http://your-ip:port";

//!For emulator
String uri = "http://10.0.2.2:3000";

class GlobalVariables {
  // COLORS
  static const appBarGradient = LinearGradient(
    colors: [
      Color.fromARGB(255, 29, 201, 192),
      Color.fromARGB(255, 125, 221, 216),
    ],
    stops: [
      0.5,
      1.0
    ],
  );

  static const secondaryColor = Color.fromRGBO(255, 153, 0, 1);
  static const backgroundColor = Colors.white;
  static const Color greyBackgroundCOlor = Color(0xffebecee);
  static const Color purpleBackgroundCOlor = Color.fromARGB(0, 35, 23, 38);
  static var selectedNavBarColor = Colors.cyan[800]!;
  static const unselectedNavBarColor = Colors.black87;

  // STATIC IMAGES
  static const List<String> carouselImages = [
    'Assets/c1.jpg',
    'Assets/c2.jpg',
    'Assets/c3.jpg',
    'Assets/c4.jpg',
    'Assets/c5.jpg',
    'Assets/c6.jpg',
  ];

  static const List<Map<String, String>> categoryImages = [
    {
      'title': 'Prime',
      'image': 'Assets/prime.png',
    },
    {
      'title': 'Fashion',
      'image': 'Assets/fashion.png',
    },
    {
      'title': 'Mobiles',
      'image': 'Assets/mobiles.png',
    },
    {
      'title': 'Deals',
      'image': 'Assets/deal.png',
    },
    {
      'title': 'miniTV',
      'image': 'Assets/tv.png',
    },
    {
      'title': 'Electronics',
      'image': 'Assets/electronics.png',
    },
    {
      'title': 'Beauty',
      'image': 'Assets/makeup.png',
    },
  ];

  static const List<Map<String, String>> smartPhoneImages = [
    {
      'title': 'oneplus',
      'image': 'Assets/oneplus.png',
    },
    {
      'title': 'samsung',
      'image': 'Assets/samsung.png',
    },
    {
      'title': 'apple',
      'image': 'Assets/apple.png',
    },
    {
      'title': 'MI',
      'image': 'Assets/mi.png',
    },
    {
      'title': 'oppo',
      'image': 'Assets/oppo.png',
    },
    {
      'title': 'motorola',
      'image': 'Assets/motorola.png',
    },
    {
      'title': 'vivo',
      'image': 'Assets/vivo.png',
    },
  ];
}
