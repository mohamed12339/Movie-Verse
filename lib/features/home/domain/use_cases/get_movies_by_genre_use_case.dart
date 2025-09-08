import 'package:injectable/injectable.dart';
import 'package:movies/core/api_result/api_result.dart';
import 'package:movies/features/home/domain/models/movie.dart';
import 'package:movies/features/home/domain/repositories/movies_repository.dart';

@injectable
class GetMoviesByGenreUseCase {
  final MoviesRepository homeRepository;
  GetMoviesByGenreUseCase(this.homeRepository);
  Future<ApiResult<List<Movie>>> call(String genre) => homeRepository.getMoviesByGenre(genre);
}