import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:project_movie_app/Features/movie_details/domain/model/entites/movie_details_dm.dart';
import 'package:project_movie_app/Features/movie_details/ui/cubit/movie_details_and_suggestion_cubit.dart';
import 'Features/movie_details/ui/view/movie_details_and_suggestion_screen.dart';
import 'core/di/di.dart';




void main() async {
  WidgetsFlutterBinding.ensureInitialized();   /// لازم دية عشان flutter يضمن ان كل حاجة جاهزة قبل استخدام async


  await Hive.initFlutter();  /// دية عشان اشتغل ب package flutter hive والي هاستخدمها في newLocalDataSource

  Hive.registerAdapter(MovieDetailsDmAdapter()); /// دا عشان اعرفوا بال adapter الانا عملتوا في ال MovieDetailsDmAdapter عشان اخزن الداتا بقا
  Hive.registerAdapter(CastEntityAdapter()); /// نفس الكلام
  Hive.registerAdapter(TorrentEntityAdapter()); /// نفس الكلام


  final watchlistBox = await Hive.openBox<MovieDetailsDm>('watchlist');  /// دا هنا بقولوا افتح box وسمية الحاجة الانا عايزها مثلا اسمها كدا وخزنوا بردوا


  getIt.registerSingleton<Box<MovieDetailsDm>>(watchlistBox);/// وهنا سجلت ال box بقا في get it عشان استخدموا في اي مكان بس

  configureDependencies(); /// دا عشان اعرف ال get it

  runApp(
    BlocProvider<MovieDetailsAndSuggestionCubit>( /// دا كان لازم اعرف دا هنا عشان سكرينة ال watchlist وال moviedetails يشتغلوا علي حاجة واحدة
      create: (_) => getIt<MovieDetailsAndSuggestionCubit>(),
      child: const MyApp(),
    ),
  );
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  final int movieId = 15;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "MovieApp",
      themeMode: ThemeMode.light,
      debugShowCheckedModeBanner: false,
      locale: const Locale("en"),
      home: MovieDetailsAndSuggestionScreen(movieId: movieId),
    );
  }
}