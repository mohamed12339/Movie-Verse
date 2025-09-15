import 'package:injectable/injectable.dart';
import 'package:project_movie_app/core/api_result/api_result.dart';
import 'package:project_movie_app/features_tmp/home/domain/repositories/movies_repository.dart';

@injectable
class GetAllGenresUseCase {
  final MoviesRepository homeRepository;
  GetAllGenresUseCase(this.homeRepository);

  Future<ApiResult<Set<String>>> call() => homeRepository.getAllGenres();
}