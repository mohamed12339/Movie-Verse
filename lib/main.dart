import 'package:flutter/material.dart';
import 'package:project_movie_app/core/di/di.dart';
import 'package:project_movie_app/core/screens/splash/splash.dart';

void main() {
  configureDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: Splash(), debugShowCheckedModeBanner: false);
  }
}
