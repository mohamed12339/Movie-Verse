import 'package:flutter/material.dart';
import 'package:project_movie_app/core/screens/home.dart';
import 'package:project_movie_app/core/screens/splash/splash.dart';
import 'package:project_movie_app/features/auth/ui/login/view/login.dart';
import 'package:project_movie_app/features/on_boarding/ui/pages/explore.dart';
import 'package:project_movie_app/features/on_boarding/ui/pages/onboarding_page.dart';

import '../features/auth/ui/register/view/register.dart';
import '../features/ui/view/movie_details_and_suggestion_screen.dart';
import '../features/ui/view/watch_list_screen.dart';

abstract final class AppRoutes {
  static Route get splash => MaterialPageRoute(builder: (_) => Splash());
  static Route get login => MaterialPageRoute(builder: (_) => Login());
  static Route get register => MaterialPageRoute(builder: (_) => Register());
  static Route get explore => MaterialPageRoute(builder: (_) => Explore());
  static Route get home => MaterialPageRoute(builder: (_) => Home());
  static Route get onboardingPage =>
      MaterialPageRoute(builder: (_) => OnBoardingPage());
  static Route movieDetails(int movieId) {
    return MaterialPageRoute(
      builder: (_) => MovieDetailsAndSuggestionScreen(movieId: movieId),
    );
  }

  static Route get watchList {
    return MaterialPageRoute(builder: (context) => WatchlistScreen());
  }
}
