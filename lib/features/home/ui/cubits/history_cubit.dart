<<<<<<< Updated upstream
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'history_state.dart';

class HistoryCubit extends Cubit<HistoryState> {
  HistoryCubit() : super(HistoryInitial());
=======
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:movies/features/home/domain/models/movie.dart';
import 'package:movies/features/home/domain/use_cases/add_movie_to_history_use_cse.dart';
import 'package:movies/features/home/domain/use_cases/get_visited_movie_history_use_case.dart';

part 'history_state.dart';

@injectable
class HistoryCubit extends Cubit<HistoryState> {
  final GetVisitedMovieHistoryUseCase getVisitedMovieHistoryUseCase;
  final AddMovieToHistoryUseCase addMovieToHistoryUseCase;

  HistoryCubit(
    this.getVisitedMovieHistoryUseCase,
    this.addMovieToHistoryUseCase,
  ) : super(HistoryStateInitial());

  Future<void> addMovieToHistory(Movie movie) async {
    emit(AddToHistoryState(isLoading: true, errorMessage: "",isSuccess: false,));
    try {
      await addMovieToHistoryUseCase.call(movie);
      emit(AddToHistoryState(isLoading: false, errorMessage: "", isSuccess: true,));
    } catch (e) {
      emit(AddToHistoryState(isLoading: false, errorMessage: e.toString(),isSuccess: false,));
    }
  }

  Future<void> getVisitedMoviesHistory() async {
    emit(GetHistoryState(isLoading: true, errorMessage: "", movies: []));
    try {
      final movies = await getVisitedMovieHistoryUseCase.call();
      if(movies.isNotEmpty){
        emit(GetHistoryState(isLoading: false, errorMessage: "", movies: movies));
      } else {
        emit(GetHistoryState(errorMessage: "No history found", isLoading: false, movies: []));
      }
    } catch (e) {
      emit(GetHistoryState(errorMessage: e.toString(), isLoading: false, movies: []));
    }
  }
>>>>>>> Stashed changes
}
