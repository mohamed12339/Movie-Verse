import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_movie_app/Features/movie_details/ui/view/video_player_screen.dart';
import 'package:project_movie_app/Features/movie_details/ui/view/watch_list_screen.dart';
import '../../../../core/api_result/api_result.dart';
import '../../../../core/di/di.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_styles.dart';
import '../../domain/model/entites/movie_details_dm.dart';
import '../../domain/model/entites/movie_suggestions_dm.dart';
import '../cubit/movie_details_and_suggestion_cubit.dart';
import '../cubit/movie_details_and_suggestion_state.dart';

class MovieDetailsAndSuggestionScreen extends StatefulWidget {
  final int movieId;

  const MovieDetailsAndSuggestionScreen({super.key, required this.movieId});

  @override
  State<MovieDetailsAndSuggestionScreen> createState() =>
      _MovieDetailsAndSuggestionScreenState();
}

class _MovieDetailsAndSuggestionScreenState
    extends State<MovieDetailsAndSuggestionScreen> {
  late final cubit = getIt<MovieDetailsAndSuggestionCubit>();

  @override
  void initState() {
    super.initState();
    cubit.loadMovieDetails(widget.movieId);
    cubit.loadMovieSuggestions(widget.movieId);
    cubit.checkWatchlist(widget.movieId);
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
    return Image.network(
      url,
      height: height,
      width: width,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) {
        return Container(
          height: height,
          width: width,
          color: AppColors.black28,
          child: const Icon(Icons.broken_image, color: Colors.white, size: 40),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black12,
      body: BlocBuilder<MovieDetailsAndSuggestionCubit,
          MovieDetailsAndSuggestionState>(
        bloc: cubit,
        builder: (context, state) {
          if (state.movieDetailsApi is LoadingApiResult ||
              state.movieSuggestionApi is LoadingApiResult) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.movieDetailsApi is ErrorApiResult ||
              state.movieSuggestionApi is ErrorApiResult) {
            return const Center(child: Text('Error loading data'));
          }

          MovieDetailsDm? movie;
          List<SuggestedMovieDM>? suggestions = [];

          if (state.movieDetailsApi is SuccessApiResult<MovieDetailsDm>) {
            movie = (state.movieDetailsApi as SuccessApiResult<MovieDetailsDm>)
                .data;
          }
          if (state.movieSuggestionApi
          is SuccessApiResult<List<SuggestedMovieDM>>) {
            suggestions = (state.movieSuggestionApi
            as SuccessApiResult<List<SuggestedMovieDM>>)
                .data;
          }

          if (movie == null) {
            return const Center(child: Text('No movie data available'));
          }

          bool isInWatchlist = false;
          if (state.isInWatchListApi is SuccessApiResult<bool>) {
            isInWatchlist =
                (state.isInWatchListApi as SuccessApiResult<bool>).data ?? false;
          }

          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Poster + Buttons
                Stack(
                  children: [
                    buildImage(movie.backgroundImage ?? movie.largeCoverImage,
                        height: 400, width: double.infinity),
                    Positioned(
                      top: 40,
                      left: 10,
                      child: IconButton(
                        icon: Icon(Icons.arrow_back, color: AppColors.white),
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
                                MaterialPageRoute(
                                    builder: (context) =>
                                    const WatchlistScreen()),
                              );
                            },
                          ),
                          IconButton(
                            icon: Icon(Icons.more_vert, color: AppColors.white),
                            onPressed: () {},
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      bottom: 20,
                      left: 20,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(movie.title, style: AppStyles.white36Mid),
                          Text(movie.titleLong ?? '', style: AppStyles.white20regular),
                          Text(movie.year.toString(),
                              style: AppStyles.white16Regular),
                        ],
                      ),
                    ),
                    Positioned(
                      bottom: 20,
                      right: 20,
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 24, vertical: 12),
                        ),
                        onPressed: movie.ytTrailerCode != null
                            ? () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => VideoPlayerScreen(
                                videoUrl:
                                "https://www.youtube.com/watch?v=${movie?.ytTrailerCode}",
                              ),
                            ),
                          );
                        }
                            : null,
                        icon: const Icon(Icons.play_arrow),
                        label: const Text(" Watch "),
                      ),
                    ),
                  ],
                ),

                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Screenshots
                      Text('Screen Shots', style: AppStyles.white24bold),
                      const SizedBox(height: 10),
                      SizedBox(
                        height: 100,
                        child: movie.screenshots.isNotEmpty
                            ? ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: movie.screenshots.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: buildImage(
                                  movie?.screenshots[index],
                                  height: 100,
                                  width: 150),
                            );
                          },
                        )
                            : Center(
                          child: Text('No screenshots available',
                              style: AppStyles.white16Regular),
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Similar Movies
                      Text('Similar', style: AppStyles.white24bold),
                      const SizedBox(height: 10),
                      SizedBox(
                        height: 400,
                        child: suggestions!.isNotEmpty
                            ? GridView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: suggestions.length,
                          gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 5,
                            crossAxisSpacing: 5,
                            childAspectRatio: 0.70,
                          ),
                          itemBuilder: (context, index) {
                            final suggestion = suggestions![index];
                            return Column(
                              children: [
                                buildImage(
                                  suggestion.coverImage ??
                                      suggestion.backgroundImage,
                                  height: 150,
                                  width: double.infinity,
                                ),
                                const SizedBox(height: 5),
                                SizedBox(
                                  width: double.infinity,
                                  child: Text(
                                    suggestion.title,
                                    style: AppStyles.white16Regular,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                Text(
                                  suggestion.rating.toString(),
                                  style: AppStyles.gold16Regular,
                                ),
                              ],
                            );
                          },
                        )
                            : Center(
                          child: Text('No similar movies',
                              style: AppStyles.white16Regular),
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
                            leading: buildImage(cast.imageUrl,
                                height: 50, width: 50),
                            title:
                            Text(cast.name, style: AppStyles.white16Regular),
                            subtitle: Text(cast.characterName ?? '',
                                style: AppStyles.white14Regular),
                          );
                        }).toList(),
                      )
                          : Center(
                        child: Text('No cast available',
                            style: AppStyles.white16Regular),
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
                            label: Text(genre,
                                style: AppStyles.white14Regular),
                            backgroundColor: AppColors.black28,
                          ),
                        )
                            .toList(),
                      )
                          : Text('No genres available',
                          style: AppStyles.white16Regular),
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
}


// class MovieDetailsAndSuggestionScreen extends StatefulWidget {
//   final int movieId;
//
//   const MovieDetailsAndSuggestionScreen({super.key, required this.movieId});
//
//   @override
//   State<MovieDetailsAndSuggestionScreen> createState() =>
//       _MovieDetailsAndSuggestionScreenState();
// }
//
// class _MovieDetailsAndSuggestionScreenState
//     extends State<MovieDetailsAndSuggestionScreen> {
//   late final cubit = getIt<MovieDetailsAndSuggestionCubit>();
//
//   @override
//   void initState() {
//     super.initState();
//     cubit.loadMovieDetails(widget.movieId);
//     cubit.loadMovieSuggestions(widget.movieId);
//     cubit.checkWatchlist(widget.movieId);
//   }
//
//   Widget buildImage(String? url, {double height = 100, double width = 100}) {
//     if (url == null || url.isEmpty) {
//       return Container(
//         height: height,
//         width: width,
//         color: AppColors.black28,
//         child: const Icon(Icons.image, color: Colors.white, size: 40),
//       );
//     }
//     return Image.network(
//       url,
//       height: height,
//       width: width,
//       fit: BoxFit.cover,
//       errorBuilder: (context, error, stackTrace) {
//         return Container(
//           height: height,
//           width: width,
//           color: AppColors.black28,
//           child: const Icon(Icons.broken_image, color: Colors.white, size: 40),
//         );
//       },
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.black12,
//       body: BlocBuilder<MovieDetailsAndSuggestionCubit,
//           MovieDetailsAndSuggestionState>(
//         bloc: cubit,
//         builder: (context, state) {
//           if (state.movieDetailsApi is LoadingApiResult ||
//               state.movieSuggestionApi is LoadingApiResult) {
//             return const Center(child: CircularProgressIndicator());
//           }
//
//           if (state.movieDetailsApi is ErrorApiResult ||
//               state.movieSuggestionApi is ErrorApiResult) {
//             return const Center(child: Text('Error loading data'));
//           }
//
//           MovieDetailsDm? movie;
//           List<SuggestedMovieDM>? suggestions = [];
//
//           if (state.movieDetailsApi is SuccessApiResult<MovieDetailsDm>) {
//             movie = (state.movieDetailsApi as SuccessApiResult<MovieDetailsDm>)
//                 .data;
//           }
//           if (state.movieSuggestionApi
//           is SuccessApiResult<List<SuggestedMovieDM>>) {
//             suggestions = (state.movieSuggestionApi
//             as SuccessApiResult<List<SuggestedMovieDM>>)
//                 .data;
//           }
//
//           if (movie == null) {
//             return const Center(child: Text('No movie data available'));
//           }
//
//           bool isInWatchlist = false;
//           if (state.isInWatchListApi is SuccessApiResult<bool>) {
//             isInWatchlist =
//                 (state.isInWatchListApi as SuccessApiResult<bool>).data ?? false;
//           }
//
//           return SingleChildScrollView(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 // Poster + Buttons
//                 Stack(
//                   children: [
//                     buildImage(movie.backgroundImage ?? movie.largeCoverImage,
//                         height: 400, width: double.infinity),
//                     Positioned(
//                       top: 40,
//                       left: 10,
//                       child: IconButton(
//                         icon: Icon(Icons.arrow_back, color: AppColors.white),
//                         onPressed: () => Navigator.pop(context),
//                       ),
//                     ),
//                     Positioned(
//                       top: 40,
//                       right: 10,
//                       child: Row(
//                         children: [
//                           IconButton(
//                             icon: Icon(
//                               isInWatchlist
//                                   ? Icons.bookmark
//                                   : Icons.bookmark_border,
//                               color: AppColors.white,
//                             ),
//                             onPressed: () {
//                               cubit.toggleWatchlist(movie!);
//                               cubit.checkWatchlist(widget.movieId);
//                               Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                     builder: (context) =>
//                                     const WatchlistScreen()),
//                               );
//                             },
//                           ),
//                           IconButton(
//                             icon: Icon(Icons.more_vert, color: AppColors.white),
//                             onPressed: () {},
//                           ),
//                         ],
//                       ),
//                     ),
//                     Positioned(
//                       bottom: 20,
//                       left: 20,
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(movie.title, style: AppStyles.white36Mid),
//                           Text(movie.titleLong ?? '', style: AppStyles.white20regular),
//                           Text(movie.year.toString(),
//                               style: AppStyles.white16Regular),
//                         ],
//                       ),
//                     ),
//                     Positioned(
//                       bottom: 20,
//                       right: 20,
//                       child: ElevatedButton.icon(
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: Colors.red,
//                           foregroundColor: Colors.white,
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(12),
//                           ),
//                           padding: const EdgeInsets.symmetric(
//                               horizontal: 24, vertical: 12),
//                         ),
//                         onPressed: movie.ytTrailerCode != null
//                             ? () {
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                               builder: (context) => VideoPlayerScreen(
//                                 videoUrl:
//                                 "https://www.youtube.com/watch?v=${movie?.ytTrailerCode}",
//                               ),
//                             ),
//                           );
//                         }
//                             : null,
//                         icon: const Icon(Icons.play_arrow),
//                         label: const Text(" Watch "),
//                       ),
//                     ),
//                   ],
//                 ),
//
//                 Padding(
//                   padding: const EdgeInsets.all(16.0),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       // Screenshots
//                       Text('Screen Shots', style: AppStyles.white24bold),
//                       const SizedBox(height: 10),
//                       SizedBox(
//                         height: 100,
//                         child: movie.screenshots.isNotEmpty
//                             ? ListView.builder(
//                           scrollDirection: Axis.horizontal,
//                           itemCount: movie.screenshots.length,
//                           itemBuilder: (context, index) {
//                             return Padding(
//                               padding: const EdgeInsets.only(right: 8.0),
//                               child: buildImage(
//                                   movie?.screenshots[index],
//                                   height: 100,
//                                   width: 150),
//                             );
//                           },
//                         )
//                             : Center(
//                           child: Text('No screenshots available',
//                               style: AppStyles.white16Regular),
//                         ),
//                       ),
//                       const SizedBox(height: 20),
//
//                       // Similar Movies
//                       Text('Similar', style: AppStyles.white24bold),
//                       const SizedBox(height: 10),
//                       SizedBox(
//                         height: 400,
//                         child: suggestions!.isNotEmpty
//                             ? GridView.builder(
//                           physics: const NeverScrollableScrollPhysics(),
//                           itemCount: suggestions.length,
//                           gridDelegate:
//                           const SliverGridDelegateWithFixedCrossAxisCount(
//                             crossAxisCount: 2,
//                             mainAxisSpacing: 5,
//                             crossAxisSpacing: 5,
//                             childAspectRatio: 0.70,
//                           ),
//                           itemBuilder: (context, index) {
//                             final suggestion = suggestions![index];
//                             return Column(
//                               children: [
//                                 buildImage(
//                                   suggestion.coverImage ??
//                                       suggestion.backgroundImage,
//                                   height: 150,
//                                   width: double.infinity,
//                                 ),
//                                 const SizedBox(height: 5),
//                                 SizedBox(
//                                   width: double.infinity,
//                                   child: Text(
//                                     suggestion.title,
//                                     style: AppStyles.white16Regular,
//                                     maxLines: 1,
//                                     overflow: TextOverflow.ellipsis,
//                                     textAlign: TextAlign.center,
//                                   ),
//                                 ),
//                                 Text(
//                                   suggestion.rating.toString(),
//                                   style: AppStyles.gold16Regular,
//                                 ),
//                               ],
//                             );
//                           },
//                         )
//                             : Center(
//                           child: Text('No similar movies',
//                               style: AppStyles.white16Regular),
//                         ),
//                       ),
//                       const SizedBox(height: 20),
//
//                       // Summary
//                       Text('Summary', style: AppStyles.white24bold),
//                       const SizedBox(height: 10),
//                       Text(movie.description, style: AppStyles.white16Regular),
//                       const SizedBox(height: 20),
//
//                       // Cast
//                       Text('Cast', style: AppStyles.white24bold),
//                       const SizedBox(height: 10),
//                       movie.cast.isNotEmpty
//                           ? Column(
//                         children: movie.cast.map((cast) {
//                           return ListTile(
//                             leading: buildImage(cast.imageUrl,
//                                 height: 50, width: 50),
//                             title:
//                             Text(cast.name, style: AppStyles.white16Regular),
//                             subtitle: Text(cast.characterName ?? '',
//                                 style: AppStyles.white14Regular),
//                           );
//                         }).toList(),
//                       )
//                           : Center(
//                         child: Text('No cast available',
//                             style: AppStyles.white16Regular),
//                       ),
//                       const SizedBox(height: 20),
//
//                       // Genres
//                       Text('Genres', style: AppStyles.white24bold),
//                       const SizedBox(height: 10),
//                       movie.genres.isNotEmpty
//                           ? Wrap(
//                         spacing: 8.0,
//                         children: movie.genres
//                             .map(
//                               (genre) => Chip(
//                             label: Text(genre,
//                                 style: AppStyles.white14Regular),
//                             backgroundColor: AppColors.black28,
//                           ),
//                         )
//                             .toList(),
//                       )
//                           : Text('No genres available',
//                           style: AppStyles.white16Regular),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
//
