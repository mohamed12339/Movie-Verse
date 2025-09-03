import 'package:flutter/material.dart';

import 'core/di/di.dart';

void main() {

  configureDependencies(); /// دا عشان نعرف الفانكشن بتاع getIt بس عشان استخدمها
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "MovieApp",
      themeMode: ThemeMode.light,
      debugShowCheckedModeBanner: false,
      locale: const Locale("en"),
    );
  }
}
