import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:project_movie_app/core/di/di.dart';
import 'package:project_movie_app/core/screens/splash/splash.dart';
import 'package:project_movie_app/core/utility/app_preferences/token_storage.dart';
import 'package:project_movie_app/features_tmp/movie_details/domain/model/entites/movie_details_dm.dart';
import 'package:project_movie_app/features_tmp/movie_details/ui/cubit/movie_details_and_suggestion_cubit.dart';
import 'package:project_movie_app/features_tmp/movie_details/ui/view/movie_details_and_suggestion_screen.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();   /// لازم دية عشان flutter يضمن ان كل حاجة جاهزة قبل استخدام async


  // Firebase + Localization
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await EasyLocalization.ensureInitialized();

  await Hive.initFlutter();  /// دية عشان اشتغل ب package flutter hive والي هاستخدمها في newLocalDataSource
  // Hive
  Hive.registerAdapter(MovieDetailsDmAdapter()); /// دا عشان اعرفوا بال adapter الانا عملتوا في ال MovieDetailsDmAdapter عشان اخزن الداتا بقا
  Hive.registerAdapter(CastEntityAdapter()); /// نفس الكلام
  Hive.registerAdapter(TorrentEntityAdapter()); /// نفس الكلام


  final watchlistBox = await Hive.openBox<MovieDetailsDm>('watchlist'); /// وهنا سجلت ال box بقا في get it عشان استخدموا في اي مكان بس
  getIt.registerSingleton<Box<MovieDetailsDm>>(watchlistBox);

  // DI
  configureDependencies(); /// دا عشان اعرف ال get it
  var isLoggedIn = (await TokenStorage.getToken()) != null;  /// طب اعرف بقا هوا عمل login or register ازاي وللة لو انا ب get ال token ومش ب null ساعتها ال user عامل login او register  ويخش علي التابات علي طول
  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('ar')],
      path: 'assets/translations',
      fallbackLocale: const Locale('en'),
      saveLocale: true,
      child: BlocProvider( /// دا كان لازم اعرف دا هنا عشان سكرينة ال watchlist وال moviedetails يشتغلوا علي حاجة واحدة
        create: (_) => getIt<MovieDetailsAndSuggestionCubit>(),
        child: MyApp(isLoggedIn: isLoggedIn),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn ; /// دية عاملها عشان اعرف هوا عمل Login ولا لا وبردو عشان register
  const MyApp({super.key, required this.isLoggedIn});
  final int movieId = 15;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: isLoggedIn? MovieDetailsAndSuggestionScreen(movieId: movieId) :Splash(),
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
    );
  }
}
