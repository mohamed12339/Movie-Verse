import 'package:movies/core/api_result/api_result.dart';
import 'package:movies/features/home/domain/models/movie.dart';
import 'package:movies/features/home/domain/repositories/visited_movies_history_repository.dart';

class AddMovieToHistoryUseCase {
  VisitedMoviesHistoryRepository visitedMoviesHistoryRepository;

  AddMovieToHistoryUseCase(this.visitedMoviesHistoryRepository);

  Future<ApiResult<void>> call(Movie movie) async {
    return await visitedMoviesHistoryRepository.addMovieToHistory(movie);
  }
}
