import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_movie_app/core/api_result/api_result.dart';
import 'package:project_movie_app/core/assets/app_assets.dart';
import 'package:project_movie_app/core/styles/app_colors.dart';
import 'package:project_movie_app/core/styles/app_styles.dart';
import 'package:project_movie_app/features_tmp/home/ui/cubits/movies_cubit.dart';
import 'package:project_movie_app/features_tmp/home/ui/widgets/error_view.dart';
import 'package:project_movie_app/features_tmp/home/ui/widgets/loading_view.dart';
import 'package:project_movie_app/features_tmp/home/ui/widgets/movies_grid_view.dart';


class SearchTab extends StatelessWidget {
  const SearchTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        children: [
          SizedBox(height: 8),
          buildSearchField(context),
          SizedBox(height: 12),

          BlocBuilder<MoviesCubit, MoviesState>(
            builder: (context, state) {
              if (state.moviesByQueryApiState is InitialApiResult) {
                return Expanded(child: buildEmptyView());
              } else if (state.moviesByQueryApiState.hasData &&
                  state.moviesByQueryApiState.myData.isEmpty) {
                return Expanded(
                  child: Center(
                    child: Text(
                      'No results found',
                      style: AppStyles.white16Regular,
                    ),
                  ),
                );
              } else if (state.moviesByQueryApiState.hasData) {
                return Expanded(
                  child: MoviesGridView(
                    movies: state.moviesByQueryApiState.myData,
                  ),
                );
              } else if (state.moviesByQueryApiState.hasError) {
                return ErrorView(
                  message: state.moviesByQueryApiState.myError.message,
                );
              } else {
                return LoadingView();
              }
            },
          ),
        ],
      ),
    );
  }

  buildSearchField(BuildContext context) {
    OutlineInputBorder border = OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(15.0)),
      borderSide: BorderSide(color: AppColors.black28),
    );
    return TextField(
      onChanged: (text) {
        BlocProvider.of<MoviesCubit>(context).getMoviesByQuery(text);
      },
      cursorColor: AppColors.white,
      style: AppStyles.white16Regular,
      decoration: InputDecoration(
        fillColor: AppColors.black28,
        filled: true,
        hintText: 'Search',
        hintStyle: AppStyles.white16Regular,
        prefixIcon: Image.asset(AppAssets.icSearch),
        border: border,
        enabledBorder: border,
        focusedBorder: border,
      ),
    );
  }

  buildEmptyView() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [Image.asset(AppAssets.emptySearch)],
    );
  }
}
