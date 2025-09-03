import '../../../../core/api_result/api_result.dart';
import '../../domain/model/entites/movie_details_dm.dart';
import '../../domain/model/entites/movie_suggestions_dm.dart';

class MovieDetailsAndSuggestionState {
  final ApiResult<MovieDetailsDm> movieDetailsApi;
  final ApiResult<List<SuggestedMovieDM>> movieSuggestionApi;

  MovieDetailsAndSuggestionState({required this.movieDetailsApi , required this.movieSuggestionApi});

  factory MovieDetailsAndSuggestionState.initial() {
    return MovieDetailsAndSuggestionState(movieDetailsApi: InitialApiResult() , movieSuggestionApi: InitialApiResult());
  }

  MovieDetailsAndSuggestionState copyWith({ApiResult<MovieDetailsDm>? movieDetailsApi , ApiResult<List<SuggestedMovieDM>>? movieSuggestionApi}) {
    return MovieDetailsAndSuggestionState(
      movieDetailsApi: movieDetailsApi ?? this.movieDetailsApi,
      movieSuggestionApi: movieSuggestionApi ?? this.movieSuggestionApi,
    );
  }
}
// class MovieSuggestionState {
//   final ApiResult<List<SuggestedMovieDM>> movieSuggestionApi;
//
//   MovieSuggestionState({required this.movieSuggestionApi});
//
//   factory MovieSuggestionState.initial() {
//     return MovieSuggestionState(movieSuggestionApi: InitialApiResult());
//   }
//
//   MovieSuggestionState copyWith({ApiResult<List<SuggestedMovieDM>>? movieSuggestionApi}) {
//     return MovieSuggestionState(
//       movieSuggestionApi: movieSuggestionApi ?? this.movieSuggestionApi,
//     );
//   }
// }