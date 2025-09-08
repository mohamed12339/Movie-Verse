import 'package:flutter/material.dart';
import 'package:movies/features/home/domain/models/movie.dart';
import 'package:movies/features/home/ui/widgets/movie_card.dart';

class MoviesGridView extends StatelessWidget {
  const MoviesGridView({super.key, required this.movies});

  final List<Movie> movies;

  @override
  Widget build(BuildContext context) {
    List<Movie> movies = this.movies;
    final double movieCardWidth = MediaQuery.of(context).size.width * 0.45;
    final double movieCardHeight = MediaQuery.of(context).size.height * 0.29;
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: movieCardWidth/movieCardHeight,
      ),
      itemCount: movies.length,
      itemBuilder: (context, index) {
        final movie = movies[index];
        return MovieCard(movie: movie,borderRadius: 16,);
      },
    );
  }
}
