import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_movie_app/core/api_result/api_result.dart';
import 'package:project_movie_app/core/assets/app_assets.dart';
import 'package:project_movie_app/core/styles/app_colors.dart';
import 'package:project_movie_app/features_tmp/home/domain/models/movie.dart';
import 'package:project_movie_app/features_tmp/home/ui/cubits/movies_cubit.dart';
import 'package:project_movie_app/features_tmp/home/ui/tabs/home_tab/movie_genre_list_view.dart';
import 'package:project_movie_app/features_tmp/home/ui/tabs/home_tab/top_rated_movies_list_view.dart';
import 'package:project_movie_app/features_tmp/home/ui/widgets/error_view.dart';
import 'package:project_movie_app/features_tmp/home/ui/widgets/loading_view.dart';



class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {

  Movie? selectedMovie;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            BlocBuilder<MoviesCubit, MoviesState>(
              builder: (context, state) {
                if (state.topRatedMoviesApiState.hasData) {
                  selectedMovie ??= state.topRatedMoviesApiState.myData.first;
                  return buildTopRatedMoviesSection(state.topRatedMoviesApiState.myData);
                } else if (state.topRatedMoviesApiState.hasError) {
                  return ErrorView(
                    message: state.topRatedMoviesApiState.myError.message,
                  );
                } else {
                  return buildTopRatedSectionLoading();
                }
              },
            ),
            SizedBox(height: 24),
            buildGenresSection(),
          ],
        ),
      ),
    );
  }

  buildTopRatedMoviesSection(List<Movie> movies) {
    return Container(
      height: MediaQuery.sizeOf(context).height * 2 / 3,
      decoration: BoxDecoration(
        image:
            selectedMovie != null
                ? DecorationImage(
                  image: CachedNetworkImageProvider(
                    selectedMovie!.largeCoverImage,
                  ),
                  fit: BoxFit.fill,
                )
                : null,
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
                movies: movies,
                onPageChanged: (movie) {
                  setState(() {
                    selectedMovie = movie;
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
    return BlocBuilder<MoviesCubit, MoviesState>(
      builder: (context, state) {
        if (state.genresApiState.hasData) {
          List<String> genres = state.genresApiState.myData.toList();
          //print(genres);
          return Column(
            spacing: 16,
            children: List.generate(genres.length, (index) {
              return BlocBuilder<MoviesCubit, MoviesState>(
                builder: (context, state) {
                  final result = state.moviesByGenreApiStates[genres[index]];
                  //print(result);
                  if (result == null || result is LoadingApiResult) {
                    return LoadingView();
                  } else if (result.hasError) {
                    return ErrorView(message: result.myError.message);
                  } else {
                    return MovieGenreListView(
                      genre: genres[index],
                      movies: result.myData,
                    );
                  }
                },
              );
            }),
          );
        } else if (state.genresApiState.hasError) {
          return ErrorView(message: state.genresApiState.myError.message);
        } else {
          return LoadingView();
        }
      },
    );
  }

  Widget buildTopRatedSectionLoading() {
    return SizedBox(
      height: MediaQuery.sizeOf(context).height * 2 / 3,
      child: Column(
        children: [
          const SizedBox(height: 16),
          Image.asset(AppAssets.availableNow),
          Expanded(child: LoadingView()),
          Image.asset(AppAssets.watchNow),
        ],
      ),
    );
  }
}
