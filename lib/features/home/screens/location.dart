// import 'package:amazon_clone/provider/user_provider.dart';
import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

class location extends StatefulWidget {
  const location({Key? key}) : super(key: key); // Corrected constructor syntax
  static const String routeName = '/location';
  @override
  State<location> createState() => _locationState();
}

class _locationState extends State<location> {
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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'ADDRESS',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(address),
            ElevatedButton(
              onPressed: () async {
                try {
                  Position position = await _getGeoLocationPosition();
                  await getAddressFromLatLong(position);
                } catch (e) {
                  print(e.toString());
                }
              },
              child: const Text('Get Location'),
            )
          ],
        ),
      ),
    );
  }
}