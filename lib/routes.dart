import 'package:amazon_clone/common/widgets/bottom_bar.dart';
import 'package:amazon_clone/features/address/screens/address_screen.dart';
import 'package:amazon_clone/features/admin/screens/add_products_screen.dart';
import 'package:amazon_clone/features/admin/screens/admin_screen.dart';
import 'package:amazon_clone/features/auth/screens/auth_screen.dart';
import 'package:amazon_clone/features/home/screens/category_deals_screen.dart';
import 'package:amazon_clone/features/home/screens/home_screen.dart';
import 'package:amazon_clone/features/product_details/screen/product_detail.dart';
import 'package:amazon_clone/features/search/screen/search_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:amazon_clone/models/product_model.dart';
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
    case searchScreen.routeName:
      var searchQuery = routeSettings.arguments as String;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => searchScreen(
          searchQuery: searchQuery,
        ),
      );
    case ProductDetails.routeName:
      var products = routeSettings.arguments as Product;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => ProductDetails(
          products: products,
        ),
      );
    case CategoryDealsScreen.routeName:
      var category = routeSettings.arguments as String;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => CategoryDealsScreen(
          category: category,
        ),
      );
    case CategoryDealsScreen.routeName:
      var category = routeSettings.arguments as String;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => CategoryDealsScreen(
          category: category,
        ),
      );
    case AddressScreen.routeName:
    var totalAmount = routeSettings.arguments as String;
      return MaterialPageRoute(
        settings: routeSettings, //This routesetting gives names and params of this particular route also provide access of data of previos screens
        builder: (_) =>  AddressScreen(totalAmount: totalAmount,),
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
