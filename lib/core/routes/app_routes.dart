import 'package:flutter/material.dart';
import 'package:project_movie_app/core/screens/splash/splash.dart';
import 'package:project_movie_app/features_tmp/auth/ui/login/view/login.dart';
import 'package:project_movie_app/features_tmp/auth/ui/register/view/register.dart';
import 'package:project_movie_app/features_tmp/home/ui/home_screen.dart';
import 'package:project_movie_app/features_tmp/home/ui/tabs/profile_tab/edit_profile.dart';
import 'package:project_movie_app/features_tmp/home/ui/tabs/profile_tab/profile_screen.dart';
import 'package:project_movie_app/features_tmp/movie_details/ui/view/movie_details_and_suggestion_screen.dart';
import 'package:project_movie_app/features_tmp/on_boarding/ui/pages/explore.dart';
import 'package:project_movie_app/features_tmp/on_boarding/ui/pages/onboarding_page.dart';
abstract final class AppRoutes {
  static Route get splash => MaterialPageRoute(builder: (_) => Splash());
  static Route get login => MaterialPageRoute(builder: (_) => Login());
  static Route get register => MaterialPageRoute(builder: (_) => Register());
  static Route get explore => MaterialPageRoute(builder: (_) => Explore());
  static Route get onboardingPage => MaterialPageRoute(builder: (_) => OnBoardingPage());
  static Route get profileTab => MaterialPageRoute(builder: (_) => ProfileTab());
  static Route get navigationTabs => MaterialPageRoute(builder: (_) => HomeScreen());

  static Route movieDetails(int movieId) {
    return MaterialPageRoute(
      builder: (_) => MovieDetailsAndSuggestionScreen(movieId: movieId),
    );
  }
  static Route editProfile( Map<String, dynamic> user) {
   return MaterialPageRoute(
      builder: (_) => EditProfileScreen(user: user),
    );
  }


}
