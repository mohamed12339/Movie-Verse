import 'package:flutter/material.dart';
import 'package:project_movie_app/core/styles/app_styles.dart';


class ErrorView extends StatelessWidget {
  final String message;
  final Function()? onRetry;

  const ErrorView({super.key, required this.message, this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(message,style: AppStyles.white20regular,),
          if (onRetry != null)
            ElevatedButton(
                onPressed: () {
                  onRetry!();
                },
                child: Text("Retry"))
        ],
      ),
    );
  }
}