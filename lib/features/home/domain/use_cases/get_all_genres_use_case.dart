import 'package:injectable/injectable.dart';
import 'package:movies/core/api_result/api_result.dart';
import 'package:movies/features/home/domain/repositories/movies_repository.dart';

@injectable
class GetAllGenresUseCase {
  final MoviesRepository homeRepository;
  GetAllGenresUseCase(this.homeRepository);

  Future<ApiResult<Set<String>>> call() => homeRepository.getAllGenres();
}