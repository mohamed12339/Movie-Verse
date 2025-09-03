import 'package:injectable/injectable.dart';
import 'package:project_movie_app/Features/movie_details/domain/repositories/movie_details_repository.dart';

import '../../../../core/api_result/api_result.dart';
import '../model/entites/movie_details_dm.dart';
import '../model/entites/movie_suggestions_dm.dart';

@injectable ///  هنا بقا i صغيرة مش كابيتال عشان دا مش abstract class وهنا كتبها عشان getit تعملوا ما هيا دية package injectable بتعمل حاجة getit بس generated لوحدها مش هتكتبها زي ال news
class MovieDetailsUseCase{
 final MovieDetailsRepository _movieDetailsRepository ;  ///  دا عشان احمل الداتا الي هيا فيها بقا MovieDetails  الانا هاستخدمها  بس وعرفتلوا ال MovieDetailsRepository بتاعة ال domain ودا سبب اني بحط ال MovieDetailsRepository في ال domain عشان ال useCase
 MovieDetailsUseCase(this._movieDetailsRepository);

 Future<ApiResult<MovieDetailsDm>>call(int movieId) =>
     _movieDetailsRepository.getMovieDetails(movieId);

}
@injectable ///  هنا بقا i صغيرة مش كابيتال عشان دا مش abstract class وهنا كتبها عشان getit تعملوا ما هيا دية package injectable بتعمل حاجة getit بس generated لوحدها مش هتكتبها زي ال news
class MovieSuggestionUseCase{
  final MovieDetailsRepository _movieDetailsRepository ; ///  دا عشان احمل الداتا الي هيا فيها بقا MovieDetails  الانا هاستخدمها  بس وعرفتلوا ال MovieDetailsRepository بتاعة ال domain ودا سبب اني بحط ال MovieDetailsRepository في ال domain عشان ال useCase
  MovieSuggestionUseCase(this._movieDetailsRepository);

  Future<ApiResult<List<SuggestedMovieDM>>>call(int movieId) =>
      _movieDetailsRepository.getMovieSuggestions(movieId);

}
