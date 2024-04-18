import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:pothole_detection/config/router/app_router.dart';
import 'package:pothole_detection/config/router/app_router.gr.dart';
import 'package:pothole_detection/services/service_locator.dart';
import 'package:pothole_detection/services/shared_preference_service.dart';

@RoutePage()
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  final sharedPreferenceService = serviceLocator<SharedPreferencesService>();
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      if (sharedPreferenceService.isLogged == false) {
        serviceLocator<AppRouter>().replace(const LoginRoute());
      } else if (sharedPreferenceService.isLogged == true &&
          sharedPreferenceService.userRole == "user") {
        serviceLocator<AppRouter>().replace(const UserPanelRoute());
      } else if (sharedPreferenceService.isLogged == true &&
          sharedPreferenceService.userRole == "admin") {
        serviceLocator<AppRouter>().replace(const AdminPanelRoute());
      }
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
        ),
      ),
    );
  }
}
