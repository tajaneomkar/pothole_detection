import 'package:flutter/material.dart';
import 'package:pothole_detection/config/router/app_router.dart';
import 'package:pothole_detection/services/service_locator.dart';
import 'package:pothole_detection/services/shared_preference_service.dart';

void main() async {
  runApp(MyApp());
  initializeDependencies();
  await serviceLocator<SharedPreferencesService>().initialise();
}

class MyApp extends StatelessWidget {
  final _appRouter = AppRouter();
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _appRouter.config(),
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: 'RobotoSlab',
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
    );
  }
}
