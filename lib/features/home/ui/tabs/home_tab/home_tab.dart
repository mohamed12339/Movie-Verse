import 'package:flutter/material.dart';
import 'package:movies/core/assets/app_assets.dart';
import 'package:movies/core/styles/app_colors.dart';
import 'package:movies/features/home/domain/models/movie.dart';
import 'package:movies/features/home/ui/tabs/home_tab/movie_genre_list_view.dart';
import 'package:movies/features/home/ui/tabs/home_tab/top_rated_movies_list_view.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  List<String> genres = [
    "Action",
    "Comedy",
    "Drama",
    "Horror",
    "Romance",
    "Sci-Fi",
    "Thriller",
  ];

  int selectedMovie = 0;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            buildTopRatedMoviesSection(),
            SizedBox(height: 24),
            buildGenresSection(),
          ],
        ),
      ),
    );
  }

  buildTopRatedMoviesSection() {
    return Container(
      height: MediaQuery.sizeOf(context).height * 2 / 3,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(Movie.dummyMovies[selectedMovie].largeCoverImage),
          fit: BoxFit.fill,
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppColors.black12.withAlpha((255 * .8).toInt()),
              AppColors.black12.withAlpha((255 * .6).toInt()),
              AppColors.black12,
            ],
          ),
        ),
        child: Column(
          children: [
            const SizedBox(height: 16),
            Image.asset(AppAssets.availableNow),
            Expanded(
              child: TopRatedMoviesListView(
                onPageChanged: (index) {
                  setState(() {
                    selectedMovie = index;
                  });
                },
              ),
            ),
            Image.asset(AppAssets.watchNow),
          ],
        ),
      ),
    );
  }

  buildGenresSection() {
    return Column(
      spacing: 16,
      children: List.generate(genres.length, (index) {
        return MovieGenreListView(genre: genres[index]);
      }),
    );
  }
}
