// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:project_movie_app/core/routes/app_routes.dart';
// import 'package:project_movie_app/core/styles/app_colors.dart';
// import 'package:project_movie_app/core/styles/app_styles.dart';
// import 'package:project_movie_app/features_tmp/movie_details/domain/model/entites/movie_details_dm.dart';
//
// import '../../../../core/api_result/api_result.dart';
//
//
// import '../cubit/movie_details_and_suggestion_cubit.dart';
// import '../cubit/movie_details_and_suggestion_state.dart';
//
// class WatchlistScreen extends StatefulWidget {
//   const WatchlistScreen({super.key});
//
//   @override
//   State<WatchlistScreen> createState() => _WatchlistScreenState();
// }
//
// class _WatchlistScreenState extends State<WatchlistScreen> {
//   late MovieDetailsAndSuggestionCubit cubit;
//
//   @override
//   void initState() {
//     super.initState();
//     cubit = BlocProvider.of<MovieDetailsAndSuggestionCubit>(context);
//
//     /// كدا عشان سكرينة ال watchlist و ال MovieDetailsAndSuggestionScreen يشتغل علي نفس اليستة
//     cubit.getWatchList();
//   }
//
//   Widget buildImage(String? url, {double height = 50, double width = 50}) {
//     if (url == null || url.isEmpty) {
//       return Container(
//         height: height,
//         width: width,
//         color: AppColors.black28,
//         child: const Icon(Icons.image, color: Colors.white),
//       );
//     }
//     return CachedNetworkImage(
//       imageUrl: url,
//       height: height,
//       width: width,
//       fit: BoxFit.cover,
//       placeholder: (context, url) => SizedBox(
//         height: height,
//         width: width,
//         child: const Center(child: CircularProgressIndicator()),
//       ),
//       errorWidget: (context, url, error) => Container(
//         height: height,
//         width: width,
//         color: AppColors.black28,
//         child: const Icon(Icons.broken_image, color: Colors.white),
//       ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.black12,
//       appBar: AppBar(
//         backgroundColor: AppColors.black21,
//         title: Text('Watchlist', style: AppStyles.white24bold),
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back, color: AppColors.white),
//           onPressed: () => Navigator.pop(context),
//         ),
//       ),
//       body:
//           BlocBuilder<
//             MovieDetailsAndSuggestionCubit,
//             MovieDetailsAndSuggestionState
//           >(
//             builder: (context, state) {
//               final watchlistApi = state.watchListApi;
//
//               if (watchlistApi is LoadingApiResult ||
//                   watchlistApi is InitialApiResult) {
//                 return const Center(child: CircularProgressIndicator());
//               }
//
//               if (watchlistApi is ErrorApiResult) {
//                 return Center(
//                   child: Text(
//                     'Error loading watchlist',
//                     style: AppStyles.white16Regular,
//                   ),
//                 );
//               }
//
//               if (watchlistApi is SuccessApiResult<List<MovieDetailsDm>>) {
//                 final watchlist = watchlistApi.data ?? [];
//                 if (watchlist.isEmpty) {
//                   return Center(
//                     child: Text(
//                       'No movies in watchlist',
//                       style: AppStyles.white16Regular,
//                     ),
//                   );
//                 }
//
//                 return ListView.builder(
//                   itemCount: watchlist.length,
//                   itemBuilder: (context, index) {
//                     final movie = watchlist[index];
//                     return InkWell(
//                       onTap: () {
//                         Navigator.push(
//                           context,
//                           AppRoutes.movieDetails(movie.id),
//                         );
//                       },
//                       child: ListTile(
//                         leading: buildImage(movie.largeCoverImage),
//                         title: Text(
//                           movie.title,
//                           style: AppStyles.white16Regular,
//                         ),
//                         subtitle: Text(
//                           'Year: ${movie.year}',
//                           style: AppStyles.white14Regular,
//                         ),
//                       ),
//                     );
//                   },
//                 );
//               }
//
//               return const SizedBox.shrink();
//             },
//           ),
//     );
//   }
// }
