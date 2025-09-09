import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/core/assets/app_assets.dart';
import 'package:movies/core/styles/app_colors.dart';
import 'package:movies/core/styles/app_styles.dart';
import 'package:movies/features/home/domain/models/movie.dart';
import 'package:movies/features/home/ui/widgets/loading_view.dart';

import '../cubits/history_cubit.dart';

class MovieCard extends StatelessWidget {
  const MovieCard({super.key, required this.movie, this.borderRadius = 20});

  final Movie movie;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        BlocProvider.of<HistoryCubit>(context).addMovieToHistory(movie);
        BlocProvider.of<HistoryCubit>(context).getVisitedMoviesHistory();
        //todo: navigate to movie details screen
      },
      child: Stack(
        fit: StackFit.expand,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(borderRadius),
            child: CachedNetworkImage(
              imageUrl: movie.largeCoverImage,
              placeholder: (context, url) => LoadingView(),
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),
            //Image.asset(movie.largeCoverImage, fit: BoxFit.fill),
          ),
          Positioned(top: 12, left: 10, child: buildRatingContainer()),
        ],
      ),
    );
  }

  buildRatingContainer() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 4, horizontal: 7),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.black12.withAlpha((255 * .7).toInt()),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(movie.rating.toString(), style: AppStyles.white16Regular),
          SizedBox(width: 2),
          Image.asset(AppAssets.icStar, width: 15),
        ],
      ),
    );
  }
}
