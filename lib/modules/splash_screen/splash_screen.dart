import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pothole_detection/modules/login/presentation/login_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 2), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const LoginPage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        // padding: EdgeInsets.all(8),
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage(
                'assets/splash.png',
              ),
              fit: BoxFit.fill),
          // gradient: LinearGradient(
          //     colors: [Colors.blue, Colors.purple],
          //     begin: Alignment.topRight,
          //     end: Alignment.bottomLeft)
        ),
      ),
    );
  }
}
