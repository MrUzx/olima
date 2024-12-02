import 'dart:async';
import 'package:document_sent/view/onboarding_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'home_page.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    _checkIfFirstTime();
  }

  Future<void> _checkIfFirstTime() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isFirstTime = prefs.getBool('isFirstTime') ?? true;

    // 3 soniyadan so'ng OnboardingScreen yoki HomePage ga o'tish
    Timer(Duration(milliseconds: 2400), () {
      if (isFirstTime) {
        prefs.setBool(
            'isFirstTime', false); // Birinchi ochilishdan so'ng, flagni saqlash
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => OnboardingPage()),
        );
      } else {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => HomePage(),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.garage_outlined),
          ],
        ),
      ),
    );
  }
}
