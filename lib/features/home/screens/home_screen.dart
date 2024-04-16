import 'package:amazon_clone/common/widgets/custom_button.dart';
import 'package:amazon_clone/features/home/widgets/carousel_image.dart';
import 'package:amazon_clone/features/home/widgets/deal_of_the_day.dart';
import 'package:amazon_clone/features/home/widgets/grids.dart';
import 'package:amazon_clone/features/home/widgets/top_categories.dart';
import 'package:amazon_clone/features/search/screen/search_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:amazon_clone/constants/global_variables.dart';
import 'package:flutter/widgets.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:amazon_clone/features/auth/services/auth_service.dart';
import 'package:provider/provider.dart';
import 'package:amazon_clone/models/user.dart';
import 'package:amazon_clone/provider/user_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  static const String routeName = '/home';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  void navigateToSearchScreen(String query) {
    Navigator.pushNamed(context, searchScreen.routeName, arguments: query);
  }

  String location = 'Null, Press Button';
  String address = 'search'; // Corrected variable name

  Future<Position> _getGeoLocationPosition() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
      throw 'Location services are disabled.'; // Use throw to throw an error
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw 'Location permissions are denied'; // Use throw to throw an error
      }
    }
    if (permission == LocationPermission.deniedForever) {
      throw 'Location permissions are permanently denied, we cannot request permissions.'; // Use throw to throw an error
    }
    return await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  }

  Future<void> getAddressFromLatLong(Position position) async {
    List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);
    print(placemarks);
    Placemark place = placemarks[0];
    setState(() {
      address = '${place.street}, ${place.locality}, ${place.postalCode}, ${place.country}';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(120),
        child: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFF84d8e2),
                  Color(0xFF92deda),
                  Color(0xFFa5e6d0)
                ],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
            ),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              SizedBox(
                height: 40,
              ),
              Row(
                children: [
                  // SizedBox(
                  //   height: 120,
                  // ),
                  const SizedBox(width: 16), // Adjust spacing if needed
                  Expanded(
                    child: Container(
                      height: 40,
                      width: 200,
                      margin: const EdgeInsets.symmetric(vertical: 2), // Adjust margin as needed
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ],
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8), // Adjust border radius as needed
                      ),
                      child: TextFormField(
                        onFieldSubmitted: navigateToSearchScreen,
                        cursorColor: GlobalVariables.selectedNavBarColor,
                        // ignore: prefer_const_constructors
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.search,
                          ),
                          hintText: 'Search Amazom.in',
                          hintStyle: TextStyle(fontSize: 13),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(horizontal: 10),
                        ),
                      ),
                    ),
                  ), // Adjust spacing if needed
                  IconButton(
                    icon: const Icon(
                      Icons.qr_code_outlined,
                      color: Colors.black,
                    ),
                    onPressed: () {
                      // Implement your notifications functionality here
                    },
                    color: Colors.white,
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.mic,
                      color: Colors.black,
                    ),
                    onPressed: () {
                      // Implement your more options functionality here
                    },
                    color: Colors.white,
                  ),
                  SizedBox(
                    width: 16,
                  ),
                ],
              ),
              Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(
                      top: 5,
                    ),
                    height: 50,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(colors: [
                      Color.fromARGB(255, 114, 226, 221),
                      Color.fromARGB(255, 162, 226, 233),
                    ])),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      child: GestureDetector(
                        onTap: () {
                          showModalBottomSheet(
                            backgroundColor: Colors.white,
                            context: context,
                            builder: (BuildContext context) {
                              return Container(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                height: 200,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                      alignment: Alignment.topLeft,
                                      height: 100,
                                      width: 200,
                                      child: Text('${Provider.of<UserProvider>(context).user.address.toString()}'),
                                    ),
                                    ElevatedButton(
                                      onPressed: () async {
                                        try {
                                          Position position = await _getGeoLocationPosition();
                                          await getAddressFromLatLong(position);
                                        } catch (e) {
                                          print(e.toString());
                                        }
                                      },
                                      child: const Text('Set Location'),
                                    ),
                                  ],
                                ),
                              );
                            },
                          );
                        },
                        child: Row(
                          children: [
                            Icon(
                              Icons.location_on_outlined,
                              color: Colors.black,
                              weight: 10,
                            ),
                            Expanded(
                              child: Text(
                                'Delivery to ${Provider.of<UserProvider>(context).user.name.toString()} - ${Provider.of<UserProvider>(context).user.address.toString()}',
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.only(
                                left: 5,
                                top: 2,
                              ),
                              child: Icon(Icons.arrow_drop_down_outlined),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ]),
          ),
          automaticallyImplyLeading: false, // To remove the back button
        ),
      ),
      body: const SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            const topCategories(),
            const SizedBox(
              height: 10,
            ),
            const CarouselImages(),
            const SizedBox(
              height: 10,
            ),
            const DealOfTheDay(),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
