// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:amazon_clone/common/widgets/custom_button.dart';
import 'package:amazon_clone/common/widgets/custom_textfiled.dart';
import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/features/auth/services/auth_service.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:flutter/material.dart';

enum Auth {
  signUp,
  signIn,
}

class AuthScreen extends StatefulWidget {
  //!This variable will be called in routes.dart file
  static const String routeName = '/auth_screen';

  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  String location = 'Null, Press Button';
  String address = ''; // Corrected variable name

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

  //!This the instance of Auth enum
  Auth _auth = Auth.signUp;
  final _signUpFormKey = GlobalKey<FormState>();
  final _signInFormKey = GlobalKey<FormState>();
  final AuthService authServices = AuthService();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _typeController = TextEditingController();

  //!For cleaning memory
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    _typeController.dispose();
  }

  void signUpUser() {
    authServices.signUpUser(context: context, email: _passwordController.text, password: _passwordController.text, name: _nameController.text, address: address, type: _typeController.text);
  }

  void signInUser() {
    authServices.signInUser(context: context, email: _passwordController.text, password: _passwordController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GlobalVariables.greyBackgroundCOlor,
      body: SingleChildScrollView(
        child: SafeArea(
            child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Welcome',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Column(
                children: [
                  ListTile(
                    tileColor: _auth == Auth.signUp ? GlobalVariables.backgroundColor : GlobalVariables.greyBackgroundCOlor,
                    title: const Text(
                      'Create Account',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    leading: Radio(
                      activeColor: GlobalVariables.secondaryColor,
                      value: Auth.signUp,
                      groupValue: _auth,
                      onChanged: (Auth? val) {
                        setState(() {
                          _auth = val!;
                        });
                      },
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(color: Colors.white),
                    child: Column(
                      children: [
                        if (_auth == Auth.signUp)
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                            child: Form(
                              key: _signUpFormKey,
                              child: Column(
                                children: [
                                  customTextField(
                                    controller: _emailController,
                                    hintText: 'Name',
                                    obSecureChar: false,
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  customTextField(
                                    controller: _passwordController,
                                    hintText: 'Email',
                                    obSecureChar: false,
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  customTextField(
                                    controller: _nameController,
                                    hintText: 'Password',
                                    obSecureChar: true,
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  customTextField(
                                    controller: _typeController,
                                    hintText: 'Who are you?',
                                    obSecureChar: false,
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  customButton(
                                      text: 'sign Up',
                                      onTap: () {
                                        if (_signUpFormKey.currentState!.validate()) {
                                          signUpUser();
                                        }
                                      }),
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
                                    child: const Text('Set Location'),
                                  )
                                ],
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                  ListTile(
                    tileColor: _auth == Auth.signIn ? GlobalVariables.backgroundColor : GlobalVariables.greyBackgroundCOlor,
                    title: Text(
                      'Sign-In',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    leading: Radio(
                      activeColor: GlobalVariables.secondaryColor,
                      value: Auth.signIn,
                      groupValue: _auth,
                      onChanged: (Auth? val) {
                        setState(() {
                          _auth = val!;
                        });
                      },
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(color: Colors.white),
                    child: Column(
                      children: [
                        if (_auth == Auth.signIn)
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                            child: Form(
                              key: _signInFormKey,
                              child: Column(
                                children: [
                                  customTextField(
                                    controller: _passwordController,
                                    obSecureChar: false,
                                    hintText: 'Email',
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  customTextField(
                                    controller: _nameController,
                                    hintText: 'Password',
                                    obSecureChar: true,
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  customButton(
                                      text: 'sign Up',
                                      onTap: () {
                                        if (_signInFormKey.currentState!.validate()) {
                                          signInUser();
                                        }
                                      }),
                                ],
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        )),
      ),
    );
  }
}
