import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pothole_detection/modules/login/presentation/login_page.dart';

class Splash_Screen extends StatefulWidget {
  const Splash_Screen({super.key});

  @override
  State<Splash_Screen> createState() => _Splash_screeStaten();
}

class _Splash_screeStaten extends State<Splash_Screen> {
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
