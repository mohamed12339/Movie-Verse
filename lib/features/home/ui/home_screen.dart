import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/core/assets/app_assets.dart';
import 'package:movies/core/di/di.dart';
import 'package:movies/core/styles/app_colors.dart';
import 'package:movies/features/home/ui/tabs/browse_tab/browse_tab.dart';
import 'package:movies/features/home/ui/tabs/home_tab/home_tab.dart';
import 'package:movies/features/home/ui/tabs/profile_tab/test_profile_screen.dart';
import 'package:movies/features/home/ui/tabs/search_tab/search_tab.dart';

import 'cubits/history_cubit.dart';
import 'cubits/movies_cubit.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  final List<Widget> _tabs = [
    HomeTab(),
    SearchTab(),
    BrowseTab(),
    TestProfileScreen(), //todo: ProfileTab()
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBody: true,
        backgroundColor: AppColors.black12,
        body: MultiBlocProvider(
          providers: [
            BlocProvider<MoviesCubit>(
              create: (BuildContext context) {
                return getIt<MoviesCubit>()
                  ..getAllGenres()
                  ..getTopRatedMovies();
              },
            ),
            BlocProvider<HistoryCubit>(
              create: (BuildContext context) {
                return getIt<HistoryCubit>();
              },
            ),
          ],
            child: _tabs[_currentIndex]),
        bottomNavigationBar: buildBottomNavigationBar(context),
      ),
    );
  }

  buildBottomNavigationBar(context) {
    return Container(
      margin: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: AppColors.black28,
        borderRadius: BorderRadius.circular(16),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: BottomNavigationBar(
          onTap: (int index) {
            setState(() {
              _currentIndex = index;
            });
          },
          type: BottomNavigationBarType.fixed,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          backgroundColor: AppColors.black28,
          selectedItemColor: AppColors.yellowF6,
          unselectedItemColor: AppColors.white,
          currentIndex: _currentIndex,
          items: [
            BottomNavigationBarItem(
              icon: ImageIcon(AssetImage(AppAssets.icHome)),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: ImageIcon(AssetImage(AppAssets.icSearch)),
              label: 'Search',
            ),
            BottomNavigationBarItem(
              icon: ImageIcon(AssetImage(AppAssets.icBrowse)),
              label: 'Browse',
            ),
            BottomNavigationBarItem(
              icon: ImageIcon(AssetImage(AppAssets.icProfile)),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}
