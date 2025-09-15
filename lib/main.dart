import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:project_movie_app/core/di/di.dart';
import 'package:project_movie_app/core/screens/splash/splash.dart';

import 'features/domain/model/entites/movie_details_dm.dart';
import 'features/ui/cubit/movie_details_and_suggestion_cubit.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Firebase + Localization
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await EasyLocalization.ensureInitialized();

  // Hive
  await Hive.initFlutter();
  Hive
    ..registerAdapter(MovieDetailsDmAdapter())
    ..registerAdapter(CastEntityAdapter())
    ..registerAdapter(TorrentEntityAdapter());

  final watchlistBox = await Hive.openBox<MovieDetailsDm>('watchlist');
  getIt.registerSingleton<Box<MovieDetailsDm>>(watchlistBox);

  // DI
  configureDependencies(); // خليه await تحسّباً

  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('ar')],
      path: 'assets/translations',
      fallbackLocale: const Locale('en'),
      saveLocale: true,
      child: BlocProvider(
        create: (_) => getIt<MovieDetailsAndSuggestionCubit>(),
        child: const MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Splash(),
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
    );
  }
}
