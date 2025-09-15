import 'package:flutter/material.dart';
import 'package:project_movie_app/features_tmp/home/domain/models/movie.dart';
import 'package:project_movie_app/features_tmp/home/ui/widgets/movie_card.dart';

import '../../../../../core/styles/app_colors.dart';
import '../../../../../core/styles/app_styles.dart';

class MovieGenreListView extends StatelessWidget {
  const MovieGenreListView({super.key, required this.genre, required this.movies});

  final String genre;
  final List<Movie> movies;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildHeader(genre),
          const SizedBox(height: 12),
          buildMoviesList(context: context, movies: movies),
        ],
      ),
    );
  }

  buildHeader(String genre) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(genre, style: AppStyles.white20regular),
        GestureDetector(
          onTap: () {
            //todo: navigate to genre movies screen
          },
          child: Row(
            children: [
              Text('See More', style: AppStyles.gold16Regular),
              SizedBox(width: 2),
              Icon(Icons.arrow_forward, color: AppColors.yellowF6, size: 16),
            ],
          ),
        ),
      ],
    );
  }

  buildMoviesList({
    required BuildContext context,
    required List<Movie> movies,
  }) {
    return SizedBox(
      height: MediaQuery.sizeOf(context).height * .2,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: movies.length,
        itemBuilder: (context, index) {
          return Container(
            width: MediaQuery.sizeOf(context).width * .32,
            margin: const EdgeInsets.only(right: 16),
            child: MovieCard(movie: movies[index], movieId: movies[index].id),
          );
        },
      ),
    );
  }
}
