import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:project_movie_app/core/api_result/api_result.dart';
import 'package:project_movie_app/features_tmp/movie_details/domain/model/entites/movie_details_dm.dart';
import 'package:project_movie_app/features_tmp/movie_details/domain/usecase/movie_details_and_suggestion_usecase.dart';
import 'package:project_movie_app/features_tmp/movie_details/domain/usecase/movie_watch_list_usecase.dart';
import 'package:project_movie_app/features_tmp/movie_details/ui/cubit/movie_details_and_suggestion_state.dart';




@injectable
///  هنا بقا i صغيرة مش كابيتال عشان دا مش abstract class وهنا كتبها عشان getit تعملوا ما هيا دية package injectable بتعمل حاجة getit بس generated لوحدها مش هتكتبها زي ال news
class MovieDetailsAndSuggestionCubit
    extends Cubit<MovieDetailsAndSuggestionState> {
  /// دا الـ Cubit الرئيسي اللي هيتحكم في الـ state بتاع MovieDetails + Suggestions

  final MovieDetailsUseCase _movieDetailsUseCase;

  /// ال UseCase المسئول علي انو يجيب  تفاصيل الفيلم

  final MovieSuggestionUseCase _movieSuggestionUseCase;

  /// ال UseCase المسئول علي انو يجيب الأفلام المقترحة

  final MovieWatchlistUseCase _movieWatchlistUseCase;

  MovieDetailsAndSuggestionCubit(
    this._movieDetailsUseCase,
    this._movieSuggestionUseCase,
    this._movieWatchlistUseCase,
  ) : super(MovieDetailsAndSuggestionState.initial());

  /// الي هاكتبوا في ال super عشان اعرفوا Cubit هيعمل اية بس وبعتلوا ال constructors

  Future<void> loadMovieDetails(int movieId) async {
    /// فانكشن عشان  تفاصيل الفيلم

    emit(state.copyWith(movieDetailsApi: LoadingApiResult()));

    /// انا هنا بقولوا الي هاتغير مين دلوقتي movieDetailsApi واعمل loading

    final result = await _movieDetailsUseCase(movieId);

    /// هنا بننادي على الـ UseCase اللي بيرجع ApiResult<MovieDetailsDm>  عشان كدا عملتها call ممكن انادي عليها كدا مش زي ال excute بتاعة ال news بس دية حاجة في dart يعني

    emit(state.copyWith(movieDetailsApi: result));

    /// هنا نفس الي state دية حاجة موجودة مع ال emit  بس الي هايتغير هوا ال movieDetailsApi ونحدثوا بقا في ال ui
  }

  Future<void> loadMovieSuggestions(int movieId) async {
    /// فانكشن عشان الأفلام المقترحة

    emit(state.copyWith(movieSuggestionApi: LoadingApiResult()));

    /// انا هنا بقولوا الي هاتغير مين دلوقتي movieSuggestionApi واعمل loading

    final result = await _movieSuggestionUseCase(movieId);

    /// هنا بننادي على الـ UseCase اللي بيرجع ApiResult<List<SuggestedMovieDM>> عشان كدا عملتها call ممكن انادي عليها كدا مش زي ال excute بتاعة ال news بس دية حاجة في dart يعني

    emit(state.copyWith(movieSuggestionApi: result));

    /// هنا نفس الي state دية حاجة موجودة مع ال emit  بس الي هايتغير هوا ال movieSuggestionApi ونحدثوا بقا في ال ui
  }

  Future<void> toggleWatchlist(MovieDetailsDm movie) async {
    emit(state.copyWith(isInWatchListApi: LoadingApiResult()));

    ///  toggle
    await _movieWatchlistUseCase.toggleWatchlist(movie: movie);

    /// بجيب البستة  الجديدة
    final result = await _movieWatchlistUseCase.getWatchlist();

    /// التعامل مع ApiResult بشكل صحيح
    if (result is SuccessApiResult<List<MovieDetailsDm>>) {
      final watchlist = result.data ?? [];
      emit(
        state.copyWith(
          watchListApi: SuccessApiResult<List<MovieDetailsDm>>(watchlist),
          isInWatchListApi: SuccessApiResult(true), /// أو false حسب إذا موجود بعد التغيير
        ),
      );
    } else if (result is ErrorApiResult) {
      emit(
        state.copyWith(
          watchListApi: ErrorApiResult(result.myError),
          isInWatchListApi: SuccessApiResult(false),
        ),
      );
    }
  }

  Future<void> checkWatchlist(int movieId) async {
    emit(state.copyWith(isInWatchListApi: LoadingApiResult()));

    final result = await _movieWatchlistUseCase.checkWatchlist(
      movieId: movieId,
    );

    /// هنا ب check علي الحاجة لو مودة

    emit(state.copyWith(isInWatchListApi: result));
  }

  Future<void> getWatchList() async {
    emit(state.copyWith(watchListApi: LoadingApiResult()));

    final result = await _movieWatchlistUseCase.getWatchlist();

    /// هنا بقا بقولوا هات الحاجة الي خزنتها

    emit(state.copyWith(watchListApi: result));
  }
}
