import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_movie_app/core/assets/app_assets.dart';
import 'package:project_movie_app/core/routes/app_routes.dart';
import 'package:project_movie_app/core/styles/app_colors.dart';
import 'package:project_movie_app/core/styles/app_styles.dart';
import 'package:project_movie_app/core/utility/app_preferences/user_storage.dart';
import 'package:project_movie_app/features_tmp/home/ui/cubits/history_cubit.dart';
import 'package:project_movie_app/features_tmp/home/ui/widgets/error_view.dart';
import 'package:project_movie_app/features_tmp/home/ui/widgets/loading_view.dart';
import 'package:project_movie_app/features_tmp/home/ui/widgets/movies_grid_view.dart';
import 'package:project_movie_app/features_tmp/movie_details/domain/model/entites/movie_details_dm.dart';
import 'package:project_movie_app/features_tmp/movie_details/ui/cubit/movie_details_and_suggestion_cubit.dart';
import 'package:project_movie_app/features_tmp/movie_details/ui/cubit/movie_details_and_suggestion_state.dart';
import 'package:project_movie_app/core/api_result/api_result.dart';

class ProfileTab extends StatefulWidget {
  const ProfileTab({super.key});

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  int selectedTab = 0; // 0 = Watchlist, 1 = History

  late MovieDetailsAndSuggestionCubit watchlistCubit;
  late HistoryCubit historyCubit;

  @override
  void initState() {
    super.initState();
    watchlistCubit = BlocProvider.of<MovieDetailsAndSuggestionCubit>(context);
    historyCubit = BlocProvider.of<HistoryCubit>(context);

    watchlistCubit.getWatchList();
    historyCubit.getVisitedMoviesHistory();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black12,
      body: FutureBuilder<Map<String, dynamic>?>( /// بكدا قولت هاتلي الي اتخزن بقا من ال register عشان مفيش api لل profile
        future: UserStorage.getUser(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data == null) {
            return buildErrorsIfThereIsNoAccountLoggedIn(context);
          }

          final user = snapshot.data!;
          return buildHistoryAndWatchListAndUserNameAndEmailAndAvatar(user, context);
        },
      ),
    );
  }

  Widget buildHistoryAndWatchListAndUserNameAndEmailAndAvatar(Map<String, dynamic> user, BuildContext context) {
    return Column(
      children: [
        // Header
        Container(
          color: AppColors.black21,
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 16),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 2,
                    child: Padding(
                      padding: const EdgeInsets.only(left:5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CircleAvatar(
                            radius: 40,
                            backgroundImage: AssetImage(
                              "assets/images/avatar${user['avatarId']}.png",
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            user['name'] ?? "",
                            style: AppStyles.white20bold,
                          ),
                          SizedBox(
                            width: 180,
                            child: Text(
                              user['email'] ?? "",
                              style: AppStyles.white16Regular,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        // Watch List count
                        BlocBuilder<MovieDetailsAndSuggestionCubit, MovieDetailsAndSuggestionState>(
                          builder: (context, state) {
                            final watchlistApi = state.watchListApi;
                            int count = 0;
                            if (watchlistApi is SuccessApiResult<List<MovieDetailsDm>>) {
                              count = watchlistApi.data?.length ?? 0;
                            }
                            return Column(
                              children: [
                                Text("$count", style: AppStyles.white24bold),
                                Text("Wish List", style: AppStyles.white16Regular),
                              ],
                            );
                          },
                        ),
                        const SizedBox(width: 40),
                        // History count
                        BlocBuilder<HistoryCubit, HistoryState>(
                          builder: (context, state) {
                            int count = 0;
                            if (state.getVisitedMoviesHistoryApiState.hasData) {
                              count = state.getVisitedMoviesHistoryApiState.myData.length;
                            }
                            return Column(
                              children: [
                                Text("$count", style: AppStyles.white24bold),
                                Text("History", style: AppStyles.white16Regular),
                              ],
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.yellowF6,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      ),
                      onPressed: () async {

                        final result = await Navigator.push(context, AppRoutes.editProfile(user));

                        if (result == true) {
                          setState(() {}); /// دا عشان يعمل  refresh للـ profile لما يعديل
                        }
                      },
                      child: Text("Edit Profile", style: AppStyles.black16Regular),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    flex: 1,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.redF8,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      ),
                      onPressed: () {
                        UserStorage.clearUser();
                        Navigator.push(context, AppRoutes.login);
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Exit", style: AppStyles.white16Regular),
                          const SizedBox(width: 6),
                          const Icon(Icons.logout, color: Colors.white, size: 18),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Container(
          color: AppColors.black21,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              buildTabItem(index: 0, icon: Icons.list, label: "Watch List"),
              buildTabItem(index: 1, icon: Icons.folder, label: "History"),
            ],
          ),
        ),
        // Content
        Expanded(
          child: IndexedStack(
            index: selectedTab,
            children: [
              // Watchlist
              BlocBuilder<MovieDetailsAndSuggestionCubit, MovieDetailsAndSuggestionState>(
                builder: (context, state) {
                  final watchlistApi = state.watchListApi;
                  if (watchlistApi is LoadingApiResult || watchlistApi is InitialApiResult) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (watchlistApi is ErrorApiResult) {
                    return Center(child: Text('Error loading watchlist', style: AppStyles.white16Regular));
                  } else if (watchlistApi is SuccessApiResult<List<MovieDetailsDm>>) {
                    final watchlist = watchlistApi.data ?? [];
                    if (watchlist.isEmpty) {
                      return Center(child: Image.asset(AppAssets.emptySearch));
                    }
                    return ListView.builder(
                      itemCount: watchlist.length,
                      itemBuilder: (context, index) {
                        final movie = watchlist[index];
                        return InkWell(
                          onTap: (){
                            Navigator.push(context, AppRoutes.movieDetails(movie.id));
                          },
                          child: ListTile(
                            leading: buildImage(movie.largeCoverImage, height: 50, width: 50),
                            title: Text(movie.title, style: AppStyles.white16Regular),
                            subtitle: Text('Year: ${movie.year}', style: AppStyles.white14Regular),
                          ),
                        );
                      },
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
              // History
              BlocBuilder<HistoryCubit, HistoryState>(
                builder: (context, state) {
                  if (state.getVisitedMoviesHistoryApiState is LoadingApiResult) {
                    return LoadingView();
                  } else if (state.getVisitedMoviesHistoryApiState.hasData &&
                      state.getVisitedMoviesHistoryApiState.myData.isNotEmpty) {
                    return MoviesGridView(
                      movies: state.getVisitedMoviesHistoryApiState.myData.reversed.toList(),
                    );
                  } else if (state.getVisitedMoviesHistoryApiState.hasError) {
                    return ErrorView(
                      message: state.getVisitedMoviesHistoryApiState.myError.message,
                    );
                  } else {
                    return Center(child: Image.asset(AppAssets.emptySearch) );
                  }
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  Center buildErrorsIfThereIsNoAccountLoggedIn(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("No user logged in", style: TextStyle(color: AppColors.white, fontSize: 18)),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              Navigator.push(context, AppRoutes.login);
            },
            child: const Text("Login"),
          ),
        ],
      ),
    );
  }

  Widget buildTabItem({required int index, required IconData icon, required String label}) {
    final isSelected = selectedTab == index;
    return InkWell(
      onTap: () {
        setState(() {
          selectedTab = index;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: isSelected ? AppColors.yellowF6 : Colors.transparent, width: 3)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: isSelected ? AppColors.yellowF6 : AppColors.white),
            const SizedBox(height: 4),
            Text(label, style: isSelected ? AppStyles.gold16Regular : AppStyles.white16Regular),
          ],
        ),
      ),
    );
  }

  Widget buildImage(String? url, {double height = 50, double width = 50}) {
    if (url == null || url.isEmpty) {
      return Container(
        height: height,
        width: width,
        color: AppColors.black28,
        child: const Icon(Icons.image, color: Colors.white),
      );
    }
    return CachedNetworkImage(
      imageUrl: url,
      height: height,
      width: width,
      fit: BoxFit.cover,
      placeholder: (context, url) => SizedBox(
        height: height,
        width: width,
        child: const Center(child: CircularProgressIndicator()),
      ),
      errorWidget: (context, url, error) => Container(
        height: height,
        width: width,
        color: AppColors.black28,
        child: const Icon(Icons.broken_image, color: Colors.white),
      ),
    );
  }
}