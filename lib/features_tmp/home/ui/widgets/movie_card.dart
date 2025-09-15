import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_movie_app/core/assets/app_assets.dart';
import 'package:project_movie_app/core/routes/app_routes.dart';
import 'package:project_movie_app/core/styles/app_styles.dart';
import 'package:project_movie_app/features_tmp/home/domain/models/movie.dart';
import 'package:project_movie_app/features_tmp/home/ui/widgets/loading_view.dart';


import '../cubits/history_cubit.dart';

class MovieCard extends StatelessWidget {
  const MovieCard({super.key, required this.movie, this.borderRadius = 20, required this.movieId});

  final Movie movie;
  final double borderRadius;
  final int movieId;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        BlocProvider.of<HistoryCubit>(context).addMovieToHistory(movie);
        BlocProvider.of<HistoryCubit>(context).getVisitedMoviesHistory();
        Navigator.push(context, AppRoutes.movieDetails(movieId));
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
