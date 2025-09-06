import 'package:flutter/material.dart';

import 'Features/movie_details/ui/view/movie_details_and_suggestion_screen.dart';
import 'core/di/di.dart';

void main() {

  configureDependencies(); /// دا عشان نعرف الفانكشن بتاع getIt بس عشان استخدمها
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  final int movieId = 15;
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "MovieApp",
      themeMode: ThemeMode.light,
      debugShowCheckedModeBanner: false,
      locale: const Locale("en"),
      home: MovieDetailsAndSuggestionScreen(movieId: movieId),
    );
  }
}
