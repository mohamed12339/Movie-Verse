import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:movies/core/api_result/api_result.dart';
import 'package:movies/features/home/domain/models/movie.dart';
import 'package:movies/features/home/domain/use_cases/add_movie_to_history_use_cse.dart';
import 'package:movies/features/home/domain/use_cases/get_visited_movie_history_use_case.dart';

part 'history_state.dart';

@injectable
class HistoryCubit extends Cubit<HistoryState> {
  final GetVisitedMovieHistoryUseCase getVisitedMovieHistoryUseCase;
  final AddMovieToHistoryUseCase addMovieToHistoryUseCase;

  HistoryCubit(this.getVisitedMovieHistoryUseCase,
      this.addMovieToHistoryUseCase,) : super(HistoryState.initial());

  Future<void> addMovieToHistory(Movie movie) async {
    emit(
        state.copyWith(addMovieToHistoryApiState: LoadingApiResult())
    );
    var result = await addMovieToHistoryUseCase(movie);
    emit(
      state.copyWith(addMovieToHistoryApiState: result),
    );
  }

  Future<void> getVisitedMoviesHistory() async {
    emit(
        state.copyWith(getVisitedMoviesHistoryApiState: LoadingApiResult())
    );
    var result = await getVisitedMovieHistoryUseCase();
    emit(
      state.copyWith(getVisitedMoviesHistoryApiState: result),
    );
  }
}
