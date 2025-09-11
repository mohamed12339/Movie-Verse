import 'package:flutter/material.dart';
import 'package:project_movie_app/core/assets/app_assets.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(image: AssetImage(AppAssets.watchNow)),
      ),
    );
  }
}
