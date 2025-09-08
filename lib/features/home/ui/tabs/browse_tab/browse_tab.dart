import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/core/api_result/api_result.dart';
import 'package:movies/core/styles/app_colors.dart';
import 'package:movies/core/styles/app_styles.dart';
import 'package:movies/features/home/domain/models/movie.dart';
import 'package:movies/features/home/ui/cubits/movies_cubit.dart';
import 'package:movies/features/home/ui/cubits/movies_cubit.dart';
import 'package:movies/features/home/ui/widgets/error_view.dart';
import 'package:movies/features/home/ui/widgets/loading_view.dart';
import 'package:movies/features/home/ui/widgets/movies_grid_view.dart';

class BrowseTab extends StatefulWidget {
  const BrowseTab({super.key});

  @override
  State<BrowseTab> createState() => _BrowseTabState();
}

class _BrowseTabState extends State<BrowseTab> {
  String? _selectedGenre;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: BlocBuilder<MoviesCubit, MoviesState>(
        builder: (context, state) {
          if (state.genresApiState.hasData &&
              state.genresApiState.getData.isNotEmpty) {
            if (_selectedGenre == null) {
              _selectedGenre = state.genresApiState.getData.first;
              BlocProvider.of<MoviesCubit>(
                context,
              ).getMoviesByGenre(_selectedGenre!);
            }
            return buildContent(genres: state.genresApiState.getData.toList());
          } else if (state.genresApiState.hasError) {
            return ErrorView(message: state.genresApiState.getError.message);
          } else {
            return LoadingView();
          }
        },
      ),
    );
  }

  buildTabBar({required List<String> genres}) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.055,
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
          BlocProvider.of<MoviesCubit>(context).getMoviesByGenre(genre);
          _selectedGenre = genre;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        margin: const EdgeInsets.only(right: 8),
        decoration: BoxDecoration(
          color:
              _selectedGenre == genre ? AppColors.yellowF6 : Colors.transparent,
          border: Border.all(color: AppColors.yellowF6, width: 2),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Center(
          child: Text(
            genre,
            style: TextStyle(
              color:
                  _selectedGenre == genre ? Colors.black : AppColors.yellowF6,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  buildContent({required List<String> genres}) {
    return Column(
      children: [
        SizedBox(height: 16),
        buildTabBar(genres: genres),
        SizedBox(height: 25),
        BlocBuilder<MoviesCubit, MoviesState>(
          builder: (context, state) {
            if (state.moviesByGenreApiState is SuccessApiResult &&
                state.moviesByGenreApiState.hasData) {
              return Expanded(
                child: MoviesGridView(
                  movies: state.moviesByGenreApiState.getData,
                ),
              );
            } else if (state.moviesByGenreApiState.hasError) {
              return Expanded(
                child: ErrorView(
                  message: state.moviesByGenreApiState.getError.message,
                ),
              );
            } else {
              return Expanded(child: LoadingView());
            }
          },
        ),
      ],
    );
  }
}
