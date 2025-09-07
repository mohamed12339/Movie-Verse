import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:movies/features/home/domain/models/movie.dart';
import 'package:movies/features/home/ui/widgets/movie_card.dart';

class TopRatedMoviesListView extends StatelessWidget {
  const TopRatedMoviesListView({super.key, required this.onPageChanged});

  final Function(int) onPageChanged;

  @override
  Widget build(BuildContext context) {
    return  CarouselSlider.builder(
      itemCount: 3,
      options: CarouselOptions(
        enableInfiniteScroll: true,
        reverse: false,
        autoPlay: false,
        enlargeCenterPage: true,
        scrollDirection: Axis.horizontal,
        height: double.infinity,
        enlargeFactor: .4,
        onPageChanged: (index, reason) {
          onPageChanged(index);
        },
        viewportFraction: .55,
      ),
      itemBuilder:
          (BuildContext context, int itemIndex, int pageViewIndex) {
        return MovieCard(movie: Movie.dummyMovies[itemIndex]);
      },
    );
  }
}
