import 'package:flutter/material.dart';
import 'package:movies/core/assets/app_assets.dart';
import 'package:movies/core/styles/app_colors.dart';
import 'package:movies/core/styles/app_styles.dart';
import 'package:movies/features/home/domain/models/movie.dart';
import 'package:movies/features/home/ui/widgets/movies_grid_view.dart';

class SearchTab extends StatelessWidget {
  const SearchTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal:  16.0),
      child: Column(
        children: [
          SizedBox(height: 8),
          buildSearchField(),
          SizedBox(height: 12),
          //Expanded(child: buildEmptyView()),
          Expanded(child: MoviesGridView(movies: Movie.dummyMovies)),
        ],
      ),
    );
  }

  buildSearchField() {
    OutlineInputBorder border = OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(15.0)),
      borderSide: BorderSide(color: AppColors.black28),
    );
    return TextField(
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
