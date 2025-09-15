import 'package:flutter/material.dart';
import 'package:project_movie_app/core/app_routes.dart';
import 'package:project_movie_app/core/assets/app_assets.dart';

import '../../domain/entities/onboarding_item.dart';
import '../widget/onboarding_content.dart';

class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({super.key});

  @override
  State<OnBoardingPage> createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  int _currentIndex = 0;

  final List<OnBoardingItem> items = [
    OnBoardingItem(
      image: AppAssets.poster1,
      title: "Discover Movies",
      description:
          "Explore a vast collection of movies in all qualities and genres. Find your next favorite film with ease.",
    ),
    OnBoardingItem(
      image: AppAssets.poster2,
      title: "Explore All Genres",
      description:
          "Discover movies from every genre, in all available qualities. Find something new and exciting to watch every day.",
    ),
    OnBoardingItem(
      image: AppAssets.poster3,
      title: "Create WatchLists",
      description:
          "Save movies to your watchlist to keep track of what you want to watch next. Enjoy films in various qualities and genres.",
    ),
    OnBoardingItem(
      image: AppAssets.poster4,
      title: "Rate, Review, and Learn",
      description:
          "Share your thoughts on the movies you've watched. Dive deep into film details and help others discover great movies with your reviews.",
    ),
    OnBoardingItem(
      image: AppAssets.poster5,
      title: "Start Watching Now",
      description: "",
    ),
  ];

  void _nextPage() {
    if (_currentIndex < items.length - 1) {
      setState(() => _currentIndex++);
    } else {
      Navigator.pushReplacement(context, AppRoutes.login);
    }
  }

  void _backPage() {
    if (_currentIndex > 0) {
      setState(() => _currentIndex--);
    }
  }

  @override
  Widget build(BuildContext context) {
    final item = items[_currentIndex];

    return Scaffold(
      backgroundColor: Colors.black,
      body: OnBoardingContent(
        item: item,
        isLast: _currentIndex == items.length - 1,
        onNext: _nextPage,
        onBack: _currentIndex > 0 ? _backPage : null,
      ),
    );
  }
}
