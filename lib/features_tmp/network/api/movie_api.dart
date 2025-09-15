import 'package:injectable/injectable.dart';
import 'package:project_movie_app/features_tmp/movie_details/data/model/movie_details_response.dart';
import 'package:project_movie_app/features_tmp/movie_details/data/model/movie_suggestions_response.dart';

import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';



part 'movie_api.g.dart'; /// دا هيتعمل لوحدوا عن طريق   build_runner
@injectable /// دا عشان يعرف ال MovieApi عند ال get it
@RestApi(baseUrl: "https://yts.mx/api/v2")
abstract class MovieApi {
  @factoryMethod /// دا  كمان بردوا عشان يعرف ال MovieApi عند ال get it
  factory MovieApi(Dio dio) = _MovieApi;/// الفايل دا ضارب ايرور او لما كان ضارب ايرور عشان انا نزلت retrofit package موجودة dependicece وال dev dependancies وال dev دية هيا عبارة عن انك زي بعمل test لحاجة او بضيف كود لوحدوا مجرد اكتب حاجة في ال terminal وهوا يضيفها لوحدوا بس  بتعمل generate لوحدها عشان تعمل clean architecture لوحدها مش زي ال news لما عملتوا فيها  فا لما تحط كدا كود dart pub run build_runner build في ال terminal هيعمل الفايل دا لوحدوا

  // Movie Details
  @GET("/movie_details.json")
  Future<HttpResponse<MovieDetailsResponse>> getMovieDetails( ///  دية @Query واديتوا الانا عايزوا بالظبط  عشان يعرف يعمل generate لل _MovieApi بدل ما روحت وعملت في ال news عملت apiManager لا هنا انا عرفت نوعوا اية زي get واديتوا ال ال path يعني بس
  @Query("movie_id") int movieId,
  @Query("with_images") bool withImages, /// بعتلوا دول لية عشان ال screen shot تظهر وال cast يظهر برضو بس كدا
  @Query("with_cast") bool withCast, /// بعتلوا دول لية عشان ال screen shot تظهر وال cast يظهر برضو بس كدا
  );

  // Movie Suggestions
  @GET("/movie_suggestions.json")
  Future<HttpResponse<MovieSuggestionsResponse>> getMovieSuggestions(@Query("movie_id") int movieId); ///  دية @Query واديتوا الانا عايزوا بالظبط  عشان يعرف يعمل generate لل _MovieApi بدل ما روحت وعملت في ال news عملت apiManager لا هنا انا عرفت نوعوا اية زي get واديتوا ال ال path يعني بس وهنا المفروض يبقا هنا يبعتلي الافلام المقترحة الي هتبقا شبة ال فيلم من افلام ال details بس
}