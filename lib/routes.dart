import 'package:amazon_clone/common/widgets/bottom_bar.dart';
import 'package:amazon_clone/features/admin/screens/add_products_screen.dart';
import 'package:amazon_clone/features/admin/screens/admin_screen.dart';
import 'package:amazon_clone/features/auth/screens/auth_screen.dart';
import 'package:amazon_clone/features/home/screens/category_deals_screen.dart';
import 'package:amazon_clone/features/home/screens/fashion.dart';
import 'package:amazon_clone/features/home/screens/home_screen.dart';
import 'package:amazon_clone/features/home/screens/mobile.dart';
import 'package:amazon_clone/features/home/screens/oneplus.dart';
import 'package:amazon_clone/features/home/screens/samsung.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

//!This Route will provide routing gateway services
//!We're using this to avoid use of Navigator.push as it have lot's of boilerplate
Route<dynamic> generateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    //!This is coming form auth folder in auth_screen
    case AuthScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings, //This routesetting gives names and params of this particular route also provide access of data of previos screens
        builder: (_) => const AuthScreen(),
      );
    case HomeScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const HomeScreen(),
      );
    case BottomBar.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const BottomBar(),
      );
    case AdminScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const AdminScreen(),
      );
    case AddProductScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const AddProductScreen(),
      );
    case CategoryDealsScreen.routeName:
      var category = routeSettings.arguments as String;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => CategoryDealsScreen(
          category: category,
        ),
      );
    case mobileCatScreen.routeName:
      var category = routeSettings.arguments as String;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => mobileCatScreen(
          category: category,
        ),
      );
    case onePlusMobile.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => onePlusMobile(),
      );
    case samsungMobile.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => samsungMobile(),
      );
    case fashionCatScreen.routeName:
      var category = routeSettings.arguments as String;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => fashionCatScreen(
          category: category,
        ),
      );
    default:
      return MaterialPageRoute(
        settings: routeSettings, //This routesetting gives names and params of this particular route also provide access of data of previos screens
        builder: (_) => const Scaffold(
          body: Center(
            child: Image(
              image: AssetImage('Assets/404.jpg'),
              fit: BoxFit.cover,
            ),
          ),
        ),
      );
  }
}
