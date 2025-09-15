import 'package:flutter/material.dart';

import 'package:project_movie_app/core/assets/app_assets.dart';
import 'package:project_movie_app/core/routes/app_routes.dart';
import 'package:project_movie_app/core/utility/app_preferences/token_storage.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    _navigate();
  }

  Future<void> _navigate() async {
    await Future.delayed(Duration(seconds: 2));
    final token = await TokenStorage.getToken();

    if (!mounted) return;

    if (token != null && token.isNotEmpty) {
    } else {
      Navigator.pushReplacement(context, AppRoutes.explore);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Image.asset(
        AppAssets.splashLogo,
        fit: BoxFit.cover,
        height: double.infinity,
        width: double.infinity,
      ),
    );
  }
}
