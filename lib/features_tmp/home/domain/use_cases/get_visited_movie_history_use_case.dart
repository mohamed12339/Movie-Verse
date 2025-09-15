
import 'package:injectable/injectable.dart';
import 'package:project_movie_app/core/api_result/api_result.dart';
import 'package:project_movie_app/features_tmp/home/domain/models/movie.dart';
import 'package:project_movie_app/features_tmp/home/domain/repositories/visited_movies_history_repository.dart';
@injectable
class GetVisitedMovieHistoryUseCase {
  VisitedMoviesHistoryRepository visitedMoviesHistoryRepository;

  GetVisitedMovieHistoryUseCase(this.visitedMoviesHistoryRepository);

  Future<ApiResult<List<Movie>>> call() async {
    return await visitedMoviesHistoryRepository.getVisitedMoviesHistory();
  }
}
