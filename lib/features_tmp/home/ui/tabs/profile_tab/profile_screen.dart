import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:project_movie_app/core/routes/app_routes.dart';
import 'package:project_movie_app/core/styles/app_colors.dart';
import 'package:project_movie_app/core/styles/app_styles.dart';
import 'package:project_movie_app/features_tmp/auth/ui/login/cubit/login_cubit.dart';
import 'package:project_movie_app/features_tmp/auth/ui/login/cubit/login_state.dart';
import 'package:project_movie_app/features_tmp/home/ui/cubits/history_cubit.dart';
import 'package:project_movie_app/features_tmp/home/ui/widgets/error_view.dart';
import 'package:project_movie_app/features_tmp/home/ui/widgets/loading_view.dart';
import 'package:project_movie_app/features_tmp/home/ui/widgets/movies_grid_view.dart';
import 'package:project_movie_app/features_tmp/movie_details/domain/model/entites/movie_details_dm.dart';
import 'package:project_movie_app/features_tmp/movie_details/ui/cubit/movie_details_and_suggestion_cubit.dart';
import 'package:project_movie_app/features_tmp/movie_details/ui/cubit/movie_details_and_suggestion_state.dart';
import 'package:project_movie_app/features_tmp/network/model/response/token_response/token_response.dart';
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
      placeholder: (context, url) =>
          SizedBox(height: height, width: width, child: const Center(child: CircularProgressIndicator())),
      errorWidget: (context, url, error) =>
          Container(height: height, width: width, color: AppColors.black28, child: const Icon(Icons.broken_image, color: Colors.white)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black12,
      body: BlocBuilder<LoginCubit, LoginState>(
        builder: (context, state) {
          if (state.loginApi is SuccessApiResult<TokenResponse>) {
            final user = (state.loginApi as SuccessApiResult<TokenResponse>).data!.data;

            return buildHistoryAndWatchList(user, context);
          }

          // Loading / Not logged in
          if (state.loginApi is LoadingApiResult<TokenResponse>) {
            return const Center(child: CircularProgressIndicator());
          }

          return buildErrorsIfThereIsNoAccountLoggedIn(context);
        },
      ),
    );
  }

  Widget buildHistoryAndWatchList(TokenData user, BuildContext context) {
    return Column(
            children: [
              // Header
              Container(
                color: AppColors.black21,
                padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 40,
                      backgroundImage: AssetImage("assets/avatars/avatar_${user.avaterId}.png"),
                    ),
                    const SizedBox(height: 8),
                    Text(user.name, style: AppStyles.white20bold),
                    const SizedBox(height: 4),
                    Text(user.email, style: AppStyles.white16Regular),
                    const SizedBox(height: 16),
                    // Counts
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                            Text("12", style: AppStyles.white24bold),
                            Text("Wish List", style: AppStyles.white16Regular),
                          ],
                        ),
                        const SizedBox(width: 40),
                        Column(
                          children: [
                            Text("10", style: AppStyles.white24bold),
                            Text("History", style: AppStyles.white16Regular),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    // Buttons
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.yellowF6,
                            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                          ),
                          onPressed: () {},
                          child: Text("Edit Profile", style: AppStyles.black16Regular),
                        ),
                        const SizedBox(width: 16),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.redF8,
                            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                          ),
                          onPressed: () {
                            Navigator.push(context, AppRoutes.login);
                          },
                          child: Row(
                            children: [
                              Text("Exit", style: AppStyles.white16Regular),
                              const SizedBox(width: 6),
                              const Icon(Icons.logout, color: Colors.white),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              // Tabs
              Container(
                color: AppColors.black21,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildTabItem(index: 0, icon: Icons.list, label: "Watch List"),
                    _buildTabItem(index: 1, icon: Icons.folder, label: "History"),
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
                            return Center(child: Text('No movies in watchlist', style: AppStyles.white16Regular));
                          }
                          return ListView.builder(
                            itemCount: watchlist.length,
                            itemBuilder: (context, index) {
                              final movie = watchlist[index];
                              return ListTile(
                                leading: buildImage(movie.largeCoverImage, height: 50, width: 50),
                                title: Text(movie.title, style: AppStyles.white16Regular),
                                subtitle: Text('Year: ${movie.year}', style: AppStyles.white14Regular),
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
                          return Center(child: Text("No visited movies yet", style: AppStyles.white20regular));
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

  Widget _buildTabItem({required int index, required IconData icon, required String label}) {
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
}