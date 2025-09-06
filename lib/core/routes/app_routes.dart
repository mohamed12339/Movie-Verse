import 'package:flutter/material.dart';

import '../../Features/movie_details/ui/view/movie_details_and_suggestion_screen.dart';

abstract class AppRoute {
  static Route movieDetails(int movieId) {
    return MaterialPageRoute(
      builder: (_) => MovieDetailsAndSuggestionScreen(movieId: movieId),
    );
  }
}