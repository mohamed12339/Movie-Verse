import 'package:flutter/material.dart';
import 'package:project_movie_app/core/app_routes.dart';
import 'package:project_movie_app/core/assets/app_assets.dart';
import 'package:project_movie_app/core/utility/app_preferences/token_storage.dart';

import '../../features/auth/domain/repositories/auth_repository.dart';
import '../di/di.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(image: AssetImage(AppAssets.watchNow)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 100,
            height: 100,
            child: ElevatedButton(
              onPressed: () {
                _logout();
              },
              child: Text("Logout"),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _logout() async {
    final token = await TokenStorage.clearToken();
    await getIt<AuthRepository>().signOut();

    if (!mounted) return;

    Navigator.pushReplacement(context, AppRoutes.login);
  }
}
