import 'package:injectable/injectable.dart';
import 'package:project_movie_app/core/api_result/api_result.dart';
import 'package:project_movie_app/features_tmp/movie_details/domain/model/entites/movie_details_dm.dart';
import 'package:project_movie_app/features_tmp/movie_details/domain/repositories/movie_details_repository.dart';



@injectable
class MovieWatchlistUseCase {
  final MovieDetailsRepository _movieDetailsRepository;
  MovieWatchlistUseCase(this._movieDetailsRepository);

  Future<ApiResult<void>> toggleWatchlist({
    required MovieDetailsDm movie,
  }) {
    return _movieDetailsRepository.toggleWatchlist(movie: movie);
  }

  Future<ApiResult<bool>> checkWatchlist({
    required int movieId,
  }) {
    return _movieDetailsRepository.checkWatchlist(movieId: movieId);
  }

  Future<ApiResult<List<MovieDetailsDm>>> getWatchlist() {
    return _movieDetailsRepository.getWatchlist();
  }
}