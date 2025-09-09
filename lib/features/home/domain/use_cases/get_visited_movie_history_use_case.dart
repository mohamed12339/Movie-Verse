import 'package:movies/features/home/domain/models/movie.dart';
import 'package:movies/features/home/domain/repositories/visited_movies_history_repository.dart';

class GetVisitedMovieHistoryUseCase {
  VisitedMoviesHistoryRepository visitedMoviesHistoryRepository;

  GetVisitedMovieHistoryUseCase(this.visitedMoviesHistoryRepository);

  Future<List<Movie>> call() async {
    return await visitedMoviesHistoryRepository.getVisitedMoviesHistory();
  }
}
