import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_movie_app/core/api_result/api_result.dart';

import 'package:project_movie_app/core/assets/app_assets.dart';
import 'package:project_movie_app/core/routes/app_routes.dart';
import 'package:project_movie_app/core/styles/app_colors.dart';
import 'package:project_movie_app/core/styles/app_styles.dart';
import 'package:project_movie_app/features_tmp/movie_details/domain/model/entites/movie_details_dm.dart';
import 'package:project_movie_app/features_tmp/movie_details/domain/model/entites/movie_suggestions_dm.dart';
import 'package:project_movie_app/features_tmp/movie_details/ui/cubit/movie_details_and_suggestion_cubit.dart';
import 'package:project_movie_app/features_tmp/movie_details/ui/cubit/movie_details_and_suggestion_state.dart';
import 'package:project_movie_app/features_tmp/movie_details/ui/widgets/torrent_button.dart';



class MovieDetailsAndSuggestionScreen extends StatefulWidget {
  final int movieId;

  const MovieDetailsAndSuggestionScreen({super.key, required this.movieId});

  @override
  State<MovieDetailsAndSuggestionScreen> createState() =>
      _MovieDetailsAndSuggestionScreenState();
}

class _MovieDetailsAndSuggestionScreenState
    extends State<MovieDetailsAndSuggestionScreen> {
  late MovieDetailsAndSuggestionCubit cubit;

  /// انا عملت كدا عشان كلهم يشتغلوا علي نفس الحاجة عشان لما اجي ادوس علي ال watchList تشتغل

  @override
  void initState() {
    /// وهنا بقا عرفتوا ال ui اني جبت من get it كل الحاجات الي هاستخدمها والفانكشن كمان اهي بس تظهر اول لما تفتح الشاشة ودا ال initSTATE عشان كدا حطيتها فيها
    super.initState();
    cubit = BlocProvider.of<MovieDetailsAndSuggestionCubit>(context);

    /// كدا عشان سكرينة ال watchlist و ال MovieDetailsAndSuggestionScreen يشتغل علي نفس اليستة
    cubit.loadMovieDetails(widget.movieId);
    cubit.loadMovieSuggestions(widget.movieId);
    cubit.checkWatchlist(widget.movieId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black12,
      body: BlocBuilder<MovieDetailsAndSuggestionCubit, MovieDetailsAndSuggestionState>(
        bloc: cubit,
        builder: (context, state) {
          if (state.movieDetailsApi is LoadingApiResult ||
              state.movieSuggestionApi is LoadingApiResult) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.movieDetailsApi is ErrorApiResult ||
              state.movieSuggestionApi is ErrorApiResult) {
            return Center(
              child: Text(
                'Error loading data',
                style: TextStyle(color: AppColors.white),
              ),
            );
          }

          MovieDetailsDm? movie;
          List<SuggestedMovieDM>? suggestions = [];

          if (state.movieDetailsApi is SuccessApiResult<MovieDetailsDm>) {
            movie = (state.movieDetailsApi as SuccessApiResult<MovieDetailsDm>)
                .data;
          }
          if (state.movieSuggestionApi
              is SuccessApiResult<List<SuggestedMovieDM>>) {
            suggestions =
                (state.movieSuggestionApi
                        as SuccessApiResult<List<SuggestedMovieDM>>)
                    .data;
          }

          if (movie == null) {
            return Center(
              child: Text(
                'No movie data available',
                style: TextStyle(color: AppColors.white),
              ),
            );
          }

          bool isInWatchlist = false;
          if (state.isInWatchListApi is SuccessApiResult<bool>) {
            isInWatchlist =
                (state.isInWatchListApi as SuccessApiResult<bool>).data ??
                false;
          }

          return SingleChildScrollView(
            child: Column(
              children: [
                // Poster + Buttons
                Stack(
                  children: [
                    buildImage(
                      movie.backgroundImage ?? movie.largeCoverImage,
                      height: 400,
                      width: double.infinity,
                    ),
                    Positioned.fill(
                      child: InkWell(
                        onTap: movie.ytTrailerCode != null
                            ? () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => TorrentButton(
                                      videoUrl:
                                          "https://www.youtube.com/watch?v=${movie?.ytTrailerCode}",
                                    ),
                                  ),
                                );
                              }
                            : null,
                        child: Image.asset(
                          AppAssets.icWatch,
                          height: 80,
                          width: 80,
                        ),
                      ),
                    ),
                    Positioned(
                      top: 40,
                      left: 10,
                      child: IconButton(
                        icon: Icon(
                          Icons.arrow_back_ios,
                          color: AppColors.white,
                        ),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ),
                    Positioned(
                      top: 40,
                      right: 10,
                      child: Row(
                        children: [
                          IconButton(
                            icon: Icon(
                              isInWatchlist
                                  ? Icons.bookmark
                                  : Icons.bookmark_border,
                              color: AppColors.white,
                            ),
                            onPressed: () {
                              cubit.toggleWatchlist(movie!);
                              cubit.checkWatchlist(widget.movieId);
                              Navigator.push(
                                context,
                                AppRoutes.watchList,
                              ).then((_) {
                                cubit.checkWatchlist(widget.movieId);

                                /// دية معناها لما اجي بقا امسحها من ايكون ال delete في ال watchList خلاص كدا تتمسح من السكرينة دية بس
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      bottom: 20,
                      left: 0,
                      right: 0,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,

                        children: [
                          Text(
                            movie.title,
                            style: AppStyles.white36Mid,
                            textAlign: TextAlign.center,
                          ),
                          Text(
                            movie.titleLong ?? '',
                            style: AppStyles.white20regular,
                            textAlign: TextAlign.center,
                          ),
                          Text(
                            movie.year.toString(),
                            style: AppStyles.white16Regular,
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 5),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    padding: EdgeInsets.symmetric(
                      horizontal: 140,
                      vertical: 15,
                    ),
                  ),
                  onPressed: movie.ytTrailerCode != null
                      ? () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => TorrentButton(
                                videoUrl:
                                    "https://www.youtube.com/watch?v=${movie?.ytTrailerCode}",

                                /// دا هايجيب اعلان الفيلم مش هاقدر اجيب الفيلم لازم بفلوس
                              ),
                            ),
                          );
                        }
                      : null,
                  icon: Icon(Icons.play_arrow),
                  label: Text(" Watch "),
                ),
                SizedBox(height: 12),
                Center(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      buildRatingAndFavAndTimeItems(
                        Icons.favorite,
                        "${movie.likeCount}",
                      ),
                      SizedBox(width: 16),
                      buildRatingAndFavAndTimeItems(
                        Icons.watch_later,
                        "${movie.runtime}",
                      ),
                      SizedBox(width: 16),
                      buildRatingAndFavAndTimeItems(
                        Icons.star,
                        "${movie.rating}",
                      ),
                      SizedBox(width: 16),
                    ],
                  ),
                ),

                Padding(
                  padding: EdgeInsets.all(18),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Screenshots
                      Text('Screen Shots', style: AppStyles.white24bold),
                      SizedBox(height: 10),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.4,

                        ///  MediaQuery عشان عايز اخد جزء من الشاشة
                        child: ListView.builder(
                          itemCount: movie.screenshots.length,
                          itemBuilder: (context, index) {
                            final shot = movie?.screenshots[index];
                            return Container(
                              margin: EdgeInsets.only(bottom: 12),
                              decoration: BoxDecoration(
                                color: AppColors.black28,
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withValues(alpha: 0.4),
                                    blurRadius: 6,
                                    offset: Offset(2, 4),
                                  ),
                                ],
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: buildImage(
                                  shot,
                                  height: 200,
                                  width: double.infinity,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      SizedBox(height: 20),

                      // Similar Movies
                      Text('Similar', style: AppStyles.white24bold),
                      const SizedBox(height: 10),
                      SizedBox(
                        height: 400,
                        child: suggestions!.isNotEmpty
                            ? GridView.builder(
                                itemCount: suggestions.length,
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      mainAxisSpacing: 12,
                                      crossAxisSpacing: 12,
                                      childAspectRatio: 0.65,
                                    ),
                                itemBuilder: (context, index) {
                                  final suggestion = suggestions![index];
                                  return InkWell(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        AppRoutes.movieDetails(suggestion.id),
                                      );
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: AppColors.black28,
                                        borderRadius: BorderRadius.circular(12),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.black.withValues(
                                              alpha: 0.3,
                                            ),
                                            blurRadius: 6,
                                            offset: const Offset(2, 4),
                                          ),
                                        ],
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.stretch,
                                        children: [
                                          Expanded(
                                            child: Stack(
                                              children: [
                                                ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.vertical(
                                                        top: Radius.circular(
                                                          12,
                                                        ),
                                                      ),
                                                  child: buildImage(
                                                    suggestion.coverImage ??
                                                        suggestion
                                                            .backgroundImage,
                                                    height: double.infinity,
                                                    width: double.infinity,
                                                  ),
                                                ),
                                                Positioned(
                                                  top: 8,
                                                  left: 8,
                                                  child: Container(
                                                    padding:
                                                        const EdgeInsets.symmetric(
                                                          horizontal: 6,
                                                          vertical: 4,
                                                        ),
                                                    decoration: BoxDecoration(
                                                      color: Colors.black54,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                            8,
                                                          ),
                                                    ),
                                                    child: Row(
                                                      children: [
                                                        Icon(
                                                          Icons.star,
                                                          color: Colors.amber,
                                                          size: 16,
                                                        ),
                                                        SizedBox(width: 4),
                                                        Text(
                                                          suggestion.rating
                                                              .toString(),
                                                          style: AppStyles
                                                              .gold16Regular,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              )
                            : Center(
                                child: Text(
                                  'No similar movies',
                                  style: AppStyles.white16Regular,
                                ),
                              ),
                      ),
                      const SizedBox(height: 20),

                      // Summary
                      Text('Summary', style: AppStyles.white24bold),
                      const SizedBox(height: 10),
                      Text(movie.description, style: AppStyles.white16Regular),
                      const SizedBox(height: 20),

                      // Cast
                      Text('Cast', style: AppStyles.white24bold),
                      const SizedBox(height: 10),
                      movie.cast.isNotEmpty
                          ? Column(
                              children: movie.cast.map((cast) {
                                return ListTile(
                                  leading: buildImage(
                                    cast.imageUrl,
                                    height: 50,
                                    width: 50,
                                  ),
                                  title: Text(
                                    cast.name,
                                    style: AppStyles.white16Regular,
                                  ),
                                  subtitle: Text(
                                    cast.characterName ?? '',
                                    style: AppStyles.white14Regular,
                                  ),
                                );
                              }).toList(),
                            )
                          : Center(
                              child: Text(
                                'No cast available',
                                style: AppStyles.white16Regular,
                              ),
                            ),
                      const SizedBox(height: 20),

                      // Genres
                      Text('Genres', style: AppStyles.white24bold),
                      const SizedBox(height: 10),
                      movie.genres.isNotEmpty
                          ? Wrap(
                              spacing: 8.0,
                              children: movie.genres
                                  .map(
                                    (genre) => Chip(
                                      label: Text(
                                        genre,
                                        style: AppStyles.white14Regular,
                                      ),
                                      backgroundColor: AppColors.black28,
                                    ),
                                  )
                                  .toList(),
                            )
                          : Text(
                              'No genres available',
                              style: AppStyles.white16Regular,
                            ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget buildRatingAndFavAndTimeItems(IconData icon, String text) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 18, vertical: 5),
      decoration: BoxDecoration(
        color: AppColors.black28,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(icon, color: AppColors.yellowFB, size: 20),
          SizedBox(width: 4),
          Text(text, style: AppStyles.gold16Regular),
        ],
      ),
    );
  }

  Widget buildImage(String? url, {double height = 100, double width = 100}) {
    if (url == null || url.isEmpty) {
      return Container(
        height: height,
        width: width,
        color: AppColors.black28,
        child: const Icon(Icons.image, color: Colors.white, size: 40),
      );
    }
    return CachedNetworkImage(
      imageUrl: url,
      height: height,
      width: width,
      fit: BoxFit.cover,
      errorWidget: (context, error, stackTrace) {
        return Container(
          height: height,
          width: width,
          color: AppColors.black28,
          child: const Icon(Icons.broken_image, color: Colors.white, size: 40),
        );
      },
    );
  }
}
