import 'package:flutter/material.dart';
import 'package:project_movie_app/Features/movie_details/ui/view/watch_list_screen.dart';

import '../../Features/movie_details/ui/view/movie_details_and_suggestion_screen.dart';

class AppRoute {
  static Route movieDetails(int movieId) {
    return MaterialPageRoute(
      builder: (_) => MovieDetailsAndSuggestionScreen(movieId: movieId),
    );
  }

  static Route get watchList {
    return MaterialPageRoute(builder: (context) => WatchlistScreen());
  }
}
