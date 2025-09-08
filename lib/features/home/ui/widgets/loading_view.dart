import 'package:flutter/material.dart';
import 'package:movies/core/styles/app_colors.dart';

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
