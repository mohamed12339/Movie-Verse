part of 'history_cubit.dart';

class HistoryState {
  int selectedIndex = 0;
  late ApiResult<void> addMovieToHistoryApiState;
  late ApiResult<List<Movie>> getVisitedMoviesHistoryApiState;

  HistoryState({
    required this.addMovieToHistoryApiState,
    required this.getVisitedMoviesHistoryApiState,

  });

  HistoryState.initial() {
    addMovieToHistoryApiState = InitialApiResult();
    getVisitedMoviesHistoryApiState = InitialApiResult();
  }

  HistoryState copyWith({
    ApiResult<void>? addMovieToHistoryApiState,
    ApiResult<List<Movie>>? getVisitedMoviesHistoryApiState,

  }) {
    return HistoryState(
      addMovieToHistoryApiState:
      addMovieToHistoryApiState ?? this.addMovieToHistoryApiState,
      getVisitedMoviesHistoryApiState: getVisitedMoviesHistoryApiState ??
          this.getVisitedMoviesHistoryApiState,
    );
  }
}
