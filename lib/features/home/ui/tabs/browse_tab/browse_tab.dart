import 'package:flutter/material.dart';
import 'package:movies/core/styles/app_colors.dart';
import 'package:movies/core/styles/app_styles.dart';
import 'package:movies/features/home/domain/models/movie.dart';
import 'package:movies/features/home/ui/widgets/movies_grid_view.dart';

class BrowseTab extends StatefulWidget {
  const BrowseTab({super.key});

  @override
  State<BrowseTab> createState() => _BrowseTabState();
}

class _BrowseTabState extends State<BrowseTab> {
  final List<String> genres = const [
    'Action',
    'Comedy',
    'Drama',
    'Horror',
    'Romance',
    'Sci-Fi',
    'Thriller',
    'Documentary',
  ];

  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(children: [
          SizedBox(height: 16,),
          buildTabBar(), SizedBox(height: 25,),
        Expanded(child: MoviesGridView(movies: Movie.dummyMovies)),
        ]),);
  }

  buildTabBar() {
    return SizedBox(
      height: MediaQuery
          .of(context)
          .size
          .height * 0.055,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: genres.length,
        itemBuilder: (context, index) {
          return buildGenreTab(genres[index], index);
        },
      ),
    );
  }

  buildGenreTab(String genre, int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _currentIndex = index;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        margin: const EdgeInsets.only(right: 8),
        decoration: BoxDecoration(
          color:
          _currentIndex == index ? AppColors.yellowF6 : Colors.transparent,
          border: Border.all(color: AppColors.yellowF6, width: 2),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Center(
          child: Text(
            genre,
            style: TextStyle(
              color: _currentIndex == index ? Colors.black : AppColors.yellowF6,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
