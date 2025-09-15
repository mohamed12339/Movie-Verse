import 'package:flutter/material.dart';
import 'package:project_movie_app/core/styles/app_colors.dart';


class LoadingView extends StatelessWidget {
  const LoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        color: AppColors.yellowF6,
      ),
    );
  }
}
