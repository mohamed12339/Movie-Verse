import '../../../../core/api_result/api_result.dart';
import '../model/entites/movie_details_dm.dart';
import '../model/entites/movie_suggestions_dm.dart';

abstract class MovieDetailsRepository { ///   ودية مكتوبة في ال domian عشان ال usecase   ودا بردوا مهمتوا انو يحمل الداتا مش مهمة ال ViewModel فا هنا هانخلي عندوا الداتا الي هيا api ونبعتها لل view model طب ولية انا عملت كدا عشان اعرف ال الحاجة offline and online يعني  الحاجة الي هاخزنها لو قفلت ال wifi ودا لو عملتها وهاخزنها بس بعدين

  Future<ApiResult<MovieDetailsDm>> getMovieDetails(int movieId);  /// انا عملت movieId زي الي فات  عشان ابعتلها ال رقم بتاع movie وكدا انا بعت الحاجات الي هاستخدمها بس تمم ومعملتش دية ليست عشان مش محتاج لان دا هوا هيجبللك فيلم واحد بس وطبعا عامل mappers
  Future<ApiResult<List<SuggestedMovieDM>>> getMovieSuggestions(int movieId); /// انا عملت movieId زي الي فات  عشان ابعتلها ال رقم بتاع movie وكدا انا بعت الحاجات الي هاستخدمها بس تمم انما دية ليستة عشان الافلام المقتلرحة فايجيبلك افلام كتير بس فا لازم في ليسة وطبعا عامل mappers


  Future<ApiResult<List<MovieDetailsDm>>> toggleWatchlist({required MovieDetailsDm movie,}); /// هنا عشان لما ادوس علي الايكون Watchlist تظهر هناك بس كدا

  Future<ApiResult<bool>> checkWatchlist({required int movieId}); /// هنا عشان اعرف لو عايز اشيلها وتتشال من ال Watchlist

}