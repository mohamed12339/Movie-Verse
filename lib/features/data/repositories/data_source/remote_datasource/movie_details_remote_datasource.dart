import 'package:project_movie_app/core/api_result/api_result.dart';
import '../../../model/movie_details_response.dart';
import '../../../model/movie_suggestions_response.dart';

abstract class MovieDetailsRemoteDataSource { /// دا الداتا الاونلاين دا هوا ال abstract الي مش هابعت فية الحاجة ال impl هوا الي هايبعت الحاجة
  Future<ApiResult<MovieDetailsResponse>> getMovieDetails(int movieId); /// انا هنا بقولوا رجعلي apiResults عشان لو فية ايرور كدا فهل هيبقا success or error or loading or initial  وكمان هيا مش هترجع api result بس لا هترجعوا علي انو MovieDetailsResponse ودية فايدة tempelete الي عملتها هناك في ال apiResult الانا عملتها هناك
  Future<ApiResult<MovieSuggestionsResponse>> getMovieSuggestions(int movieId); /// نفس الكلام هنا بردو
}