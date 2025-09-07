import 'package:flutter/material.dart';
import 'package:movies/core/styles/app_colors.dart';
import 'package:movies/core/styles/app_styles.dart';
import 'package:movies/features/home/domain/models/movie.dart';
import 'package:movies/features/home/ui/widgets/movie_card.dart';

class MovieGenreListView extends StatelessWidget {
  const MovieGenreListView({super.key, required this.genre});

  final String genre;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildHeader(genre),
          const SizedBox(height: 12),
          buildMoviesList(context),
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

  buildMoviesList(BuildContext context) {
    return SizedBox(
      height: MediaQuery.sizeOf(context).height * .2,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: Movie.dummyMovies.length,
        itemBuilder: (context, index) {
          return Container(
            width: MediaQuery.sizeOf(context).width * .32,
            margin: const EdgeInsets.only(right: 16),
            child: MovieCard(movie: Movie.dummyMovies[index]),
          );
        },
      ),
    );
  }
}
