import 'dart:async';
import 'package:air_bnb_app/view/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
 // Replace with the actual import for your next screen

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Start a timer to navigate to the next screen after 3 seconds
    Timer(Duration(seconds: 3), () {
      // Navigate to the next screen
      Get.to(() => LoginScreen()); // Replace with your actual next screen
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.pinkAccent,
              Colors.amber,
            ],
            begin: FractionalOffset(0, 0),
            end: FractionalOffset(1, 0),
            stops: [0, 1],
            tileMode: TileMode.clamp,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('images/images (1).jpeg',), // Replace with your actual image asset
              Padding(
                padding: const EdgeInsets.only(top: 18.0),
                child: Text(
                  'Welcome to Airbnb Clone',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
