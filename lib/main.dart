import 'package:flutter/material.dart';
import 'package:movies/core/di/di.dart';
import 'package:movies/features/home/data/utils/hive_adapters/movie_adapter.dart';
import 'package:movies/features/home/ui/home_screen.dart';
import 'package:hive_flutter/hive_flutter.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Hive.initFlutter();
  Hive.registerAdapter(MovieAdapter());
  configureDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}
