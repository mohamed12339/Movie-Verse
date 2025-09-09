import 'package:movies/features/home/domain/models/movie.dart';
import 'package:movies/features/home/domain/repositories/visited_movies_history_repository.dart';

class AddMovieToHistoryUseCase {
  VisitedMoviesHistoryRepository visitedMoviesHistoryRepository;

  AddMovieToHistoryUseCase(this.visitedMoviesHistoryRepository);

  Future<void> call(Movie movie) async {
    visitedMoviesHistoryRepository.addMovieToHistory(movie);
  }
}
