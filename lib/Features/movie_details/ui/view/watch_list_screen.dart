import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_movie_app/Features/movie_details/domain/model/entites/movie_details_dm.dart';
import 'package:project_movie_app/Features/movie_details/ui/cubit/movie_details_and_suggestion_cubit.dart';
import 'package:project_movie_app/core/styles/app_colors.dart';
import 'package:project_movie_app/core/styles/app_styles.dart';
import 'package:project_movie_app/core/di/di.dart';
import '../../../../core/api_result/api_result.dart';
import '../cubit/movie_details_and_suggestion_state.dart';

class WatchlistScreen extends StatelessWidget {
  const WatchlistScreen({super.key});

  Widget buildImage(String? url, {double height = 50, double width = 50}) {
    if (url == null || url.isEmpty) {
      return Container(
        height: height,
        width: width,
        color: AppColors.black28,
        child: const Icon(Icons.image, color: Colors.white),
      );
    }
    return Image.network(
      url,
      height: height,
      width: width,
      fit: BoxFit.cover,
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) return child;
        return SizedBox(
          height: height,
          width: width,
          child: const Center(child: CircularProgressIndicator()),
        );
      },
      errorBuilder: (context, error, stackTrace) {
        return Container(
          height: height,
          width: width,
          color: AppColors.black28,
          child: const Icon(Icons.broken_image, color: Colors.white),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final cubit = getIt<MovieDetailsAndSuggestionCubit>();

    return BlocProvider.value(
      value: cubit,
      child: Scaffold(
        backgroundColor: AppColors.black12,
        appBar: AppBar(
          backgroundColor: AppColors.black21,
          title: Text('Watchlist', style: AppStyles.white24bold),
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: AppColors.white),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: BlocBuilder<MovieDetailsAndSuggestionCubit, MovieDetailsAndSuggestionState>(
          builder: (context, state) {
            final watchlistApi = state.watchListApi;

            if (watchlistApi is LoadingApiResult || watchlistApi is InitialApiResult) {
              return const Center(child: CircularProgressIndicator());
            }

            if (watchlistApi is ErrorApiResult) {
              return Center(
                child: Text('Error loading watchlist', style: AppStyles.white16Regular),
              );
            }

            // لو النتيجة SuccessApiResult يبقى نعرض الأفلام
            if (watchlistApi is SuccessApiResult<List<MovieDetailsDm>>) {
              final watchlist = watchlistApi.data;
              if (watchlist == null || watchlist.isEmpty) {
                return Center(
                  child: Text('No movies in watchlist', style: AppStyles.white16Regular),
                );
              }

              return ListView.builder(
                itemCount: watchlist.length,
                itemBuilder: (context, index) {
                  final movie = watchlist[index];
                  return ListTile(
                    leading: buildImage(movie.largeCoverImage),
                    title: Text(movie.title, style: AppStyles.white16Regular),
                    subtitle: Text('Year: ${movie.year}', style: AppStyles.white14Regular),
                    trailing: IconButton(
                      icon: Icon(Icons.delete, color: AppColors.redF8),
                      onPressed: () {
                        cubit.toggleWatchlist(movie);
                      },
                    ),
                  );
                },
              );
            }

            // fallback لأي حالة غير متوقعة
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
