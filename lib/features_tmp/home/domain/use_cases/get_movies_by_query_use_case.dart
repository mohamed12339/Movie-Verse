import 'package:injectable/injectable.dart';
import 'package:project_movie_app/core/api_result/api_result.dart';
import 'package:project_movie_app/features_tmp/home/domain/models/movie.dart';
import 'package:project_movie_app/features_tmp/home/domain/repositories/movies_repository.dart';

@injectable
class GetMoviesByQueryUseCase {
  final MoviesRepository homeRepository;
  GetMoviesByQueryUseCase(this.homeRepository);
  Future<ApiResult<List<Movie>>> call(String query) => homeRepository.getMoviesByQuery(query);
}