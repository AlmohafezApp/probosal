//import 'dart:js';
import 'package:flutter/material.dart';

import 'package:voice_recognition/Screens/login.dart';
import 'package:voice_recognition/colors.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToHomeScreen();
  }

  _navigateToHomeScreen() async {
    await Future.delayed(Duration(milliseconds: 1500), () {});
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => LogInScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          "Muhaffez App",
          style: TextStyle(
              color: maincolor, fontWeight: FontWeight.bold, fontSize: 30),
        ),
      ),
    );
  }
}
