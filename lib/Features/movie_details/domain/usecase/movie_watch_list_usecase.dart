import 'package:injectable/injectable.dart';

import '../../../../core/api_result/api_result.dart';
import '../model/entites/movie_details_dm.dart';
import '../repositories/movie_details_repository.dart';

@injectable
class MovieWatchlistUseCase {
  final MovieDetailsRepository _movieDetailsRepository;
  MovieWatchlistUseCase(this._movieDetailsRepository);

  Future<ApiResult<List<MovieDetailsDm>>> toggleWatchlist({
    required MovieDetailsDm movie,
  }) {
    return _movieDetailsRepository.toggleWatchlist(movie: movie);
  }

  Future<ApiResult<bool>> checkWatchlist({
    required int movieId,
  }) {
    return _movieDetailsRepository.checkWatchlist(movieId: movieId);
  }
}