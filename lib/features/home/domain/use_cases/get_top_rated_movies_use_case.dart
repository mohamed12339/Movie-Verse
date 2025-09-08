import 'package:injectable/injectable.dart';
import 'package:movies/core/api_result/api_result.dart';
import 'package:movies/features/home/domain/models/movie.dart';
import 'package:movies/features/home/domain/repositories/movies_repository.dart';

@injectable
class GetTopRatedMoviesUseCase {
  final MoviesRepository homeRepository;
  GetTopRatedMoviesUseCase(this.homeRepository);
  Future<ApiResult<List<Movie>>> call() => homeRepository.getTopRatedMovies();
}