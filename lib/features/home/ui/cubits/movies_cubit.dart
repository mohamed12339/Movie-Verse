import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:movies/core/api_result/api_result.dart';
import 'package:movies/features/home/domain/models/movie.dart';
import 'package:movies/features/home/domain/use_cases/get_all_genres_use_case.dart';
import 'package:movies/features/home/domain/use_cases/get_movies_by_genre_use_case.dart';
import 'package:movies/features/home/domain/use_cases/get_movies_by_query_use_case.dart';
import 'package:movies/features/home/domain/use_cases/get_top_rated_movies_use_case.dart';

part 'movies_state.dart';

@injectable
class MoviesCubit extends Cubit<MoviesState> {
  final GetTopRatedMoviesUseCase _getTopRatedMoviesUseCase;
  final GetMoviesByGenreUseCase _getMoviesByGenreUseCase;
  final GetMoviesByQueryUseCase _getMoviesByQueryUseCase;
  final GetAllGenresUseCase _getGenresUseCase;

  MoviesCubit(
    this._getTopRatedMoviesUseCase,
    this._getMoviesByGenreUseCase,
    this._getMoviesByQueryUseCase,
    this._getGenresUseCase,
  ) : super(MoviesState.initial());

  void getTopRatedMovies() async {
    try {
      emit(state.copyWith(topRatedMoviesApiState: LoadingApiResult()));
      final result = await _getTopRatedMoviesUseCase();
      emit(state.copyWith(topRatedMoviesApiState: result));
    } on Exception catch (e) {
      emit(
        state.copyWith(
          topRatedMoviesApiState: ErrorApiResult(AppErrors(e.toString())),
        ),
      );
    }
  }

  void getMoviesByGenre(String genre) async {
    //try {
      emit(state.copyWith(moviesByGenreApiState: LoadingApiResult()));
      final result = await _getMoviesByGenreUseCase(genre);
      emit(state.copyWith(moviesByGenreApiState: result));
    // } on Exception catch (e) {
    //   emit(
    //     state.copyWith(
    //       moviesByGenreApiState: ErrorApiResult(AppErrors(e.toString())),
    //     ),
    //   );
    // }
  }

  void getMoviesForAllGenres(List<String> genres) async {
    //try {
      emit(
        state.copyWith(
          moviesByGenreApiStates: {
            for (var element in genres) element: LoadingApiResult(),
          },
        ),
      );
      for (var element in genres) {
        //print("genre: $element");
        final result = await _getMoviesByGenreUseCase(element);
        //print("result: $result");
        emit(state.copyWith(moviesByGenreApiStates: {
          ...state.moviesByGenreApiStates,
          element: result,
        }));
      }
    // } on Exception catch (e) {
    //   emit(
    //     state.copyWith(
    //       moviesByGenreApiStates: {
    //         for (var element in genres)
    //           element: ErrorApiResult(AppErrors(e.toString())),
    //       },
    //     ),
    //   );
    // }
  }

  void getMoviesByQuery(String query) async {
    try {
      emit(state.copyWith(moviesByQueryApiState: LoadingApiResult()));
      final result = await _getMoviesByQueryUseCase(query);
      emit(state.copyWith(moviesByQueryApiState: result));
    } on Exception catch (e) {
      emit(
        state.copyWith(
          moviesByQueryApiState: ErrorApiResult(AppErrors(e.toString())),
        ),
      );
    }
  }

  void getAllGenres() async {
    //try {
      emit(state.copyWith(genresApiState: LoadingApiResult()));
      final result = await _getGenresUseCase();
      emit(state.copyWith(genresApiState: result));
      if(result.hasData){
        getMoviesForAllGenres(result.getData.toList());
      //}
    // } on Exception catch (e) {
    //   emit(
    //     state.copyWith(genresApiState: ErrorApiResult(AppErrors(e.toString()))),
    //   );
    }
  }
}
