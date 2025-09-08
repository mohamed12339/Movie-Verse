part of 'movies_cubit.dart';

class MoviesState<T> {
  int selectedIndex = 0;
  late ApiResult<Set<String>> genresApiState;
  late ApiResult<List<Movie>> moviesByQueryApiState;
  late ApiResult<List<Movie>> topRatedMoviesApiState;
  late ApiResult<List<Movie>> moviesByGenreApiState;
  late Map<String, ApiResult<List<Movie>>> moviesByGenreApiStates;

  MoviesState({
    required this.genresApiState,
    required this.moviesByQueryApiState,
    required this.topRatedMoviesApiState,
    required this.moviesByGenreApiState,
    required this.moviesByGenreApiStates,
  });

  MoviesState.initial() {
    genresApiState = InitialApiResult();
    moviesByGenreApiState = InitialApiResult();
    topRatedMoviesApiState = InitialApiResult();
    moviesByQueryApiState = InitialApiResult();
    moviesByGenreApiStates = {"": InitialApiResult()};
  }

  MoviesState<T> copyWith({
    ApiResult<List<Movie>>? topRatedMoviesApiState,
    ApiResult<Set<String>>? genresApiState,
    ApiResult<List<Movie>>? moviesByGenreApiState,
    ApiResult<List<Movie>>? moviesByQueryApiState,
    Map<String, ApiResult<List<Movie>>>? moviesByGenreApiStates,
  }) {
    return MoviesState(
      topRatedMoviesApiState:
          topRatedMoviesApiState ?? this.topRatedMoviesApiState,
      genresApiState: genresApiState ?? this.genresApiState,
      moviesByGenreApiState:
          moviesByGenreApiState ?? this.moviesByGenreApiState,
      moviesByQueryApiState:
          moviesByQueryApiState ?? this.moviesByQueryApiState,
      moviesByGenreApiStates: moviesByGenreApiStates ?? this.moviesByGenreApiStates,
    );
  }
}
