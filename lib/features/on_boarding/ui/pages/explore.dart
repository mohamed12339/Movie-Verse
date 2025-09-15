import 'package:flutter/material.dart';
import 'package:project_movie_app/core/app_routes.dart';
import 'package:project_movie_app/core/assets/app_assets.dart';
import 'package:project_movie_app/core/styles/app_styles.dart';

class Explore extends StatelessWidget {
  const Explore({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(AppAssets.mainPoster),
          fit: BoxFit.cover,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(right: 16, left: 16, bottom: 33),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              "Find Your Next Favorite Movie Here",
              style: AppStyles.white36Mid,
              textAlign: TextAlign.center,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: Text(
                "Get access to a huge library of movies to suit all tastes. You will surely like it.",
                style: AppStyles.white20regularOpacity60,
                textAlign: TextAlign.center,
              ),
            ),
            Container(
              width: double.infinity,
              margin: EdgeInsets.only(top: 24, left: 16, right: 16),
              child: ElevatedButton(
                style: ButtonStyle(
                  shape: WidgetStatePropertyAll(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  backgroundColor: WidgetStatePropertyAll(Color(0xffF6BD00)),
                ),
                onPressed: () {
                  Navigator.pushReplacement(context, AppRoutes.onboardingPage);
                },
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  child: Text("Explore Now", style: AppStyles.black20SemiBold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
