
import 'package:injectable/injectable.dart';
import 'package:project_movie_app/core/api_result/api_result.dart';
import 'package:project_movie_app/features_tmp/movie_details/data/mapper/movie_details_mapper.dart';
import 'package:project_movie_app/features_tmp/movie_details/data/mapper/movie_suggestions_mapper.dart';
import 'package:project_movie_app/features_tmp/movie_details/data/model/movie_details_response.dart';
import 'package:project_movie_app/features_tmp/movie_details/data/model/movie_suggestions_response.dart';
import 'package:project_movie_app/features_tmp/movie_details/data/repositories/data_source/local_datasource/movie_details_local_datasource.dart';
import 'package:project_movie_app/features_tmp/movie_details/data/repositories/data_source/remote_datasource/movie_details_remote_datasource.dart';
import 'package:project_movie_app/features_tmp/movie_details/domain/model/entites/movie_details_dm.dart';
import 'package:project_movie_app/features_tmp/movie_details/domain/model/entites/movie_suggestions_dm.dart';
import 'package:project_movie_app/features_tmp/movie_details/domain/repositories/movie_details_repository.dart';


@Injectable(as: MovieDetailsRepository)
/// اهم حاجة انا مستخدم Injectable الي هيا بال I كدا عشان  دية انا عملتها عشان اقولوا لو طلبت abstract class دا   (as: MovieDetailsRepository) دا ابعتلي child ال (MovieDetailsRepositoryImpl) بتاعوا زي ال news كدا لما عملتها في get it فايل بالظبط  بس هنا بقا هايعملها لوحدوا generated
class MovieDetailsRepositoryImpl extends MovieDetailsRepository {
  /// فايدة حتة الي impl واعمل extend لل abstract class بتاعها هيا ال coupling  يعني لو حصل تغير فا انتا مثلا تغير في كلاس impl مش هايحصل حاجة لل abstract كلاس خالص ودا فايدتوا ان لو حصل تغير في ال project هنغير حاجة مثلا تروح تغيرها في ال impl2 وهيا كدا كدا هتسمع في ال abstract class و ال impl1  لانها فانكشن فاضية بس بتعملها override من عند ال impl 1 and 2 بس فا بتغير هناك
  final MovieDetailsRemoteDataSource _remoteDataSource;

  /// دا الداتا الاونلاين
  final MovieDetailsMapper movieDetailsMapper;

  /// عرفت ال MovieDetailsMapper عشان استخدم الحاجة الي الانا عايزها من الكلاس الكبير الي موجود في ال data واقدر استخدم هنا MovieDetailsDm بتاع ال domain بس
  final MovieSuggestionsMapper movieSuggestionsMapper;

  /// عرفت ال MovieSuggestionsMapper عشان استخدم الحاجة الي الانا عايزها من الكلاس الكبير الي موجود في ال data واقدر استخدم هنا MovieSuggestionsDm بتاع ال domain بس
  final MovieDetailsLocalDatasource _movieDetailsLocalDatasource;
  MovieDetailsRepositoryImpl(
    this._remoteDataSource,
    this.movieDetailsMapper,
    this.movieSuggestionsMapper,
    this._movieDetailsLocalDatasource,
  );

  @override
  Future<ApiResult<MovieDetailsDm>> getMovieDetails(int movieId) async {
    ///  هنا بعمل Override للفانكشن اللي في الـ abstract Repository الفانكشن وظيفتها تجيب Movie واحد بالتفاصيل بتاعته باستخدام الـ movieId

    final result = await _remoteDataSource.getMovieDetails(movieId);

    ///  هنا بنادي على الـ RemoteDataSource اللي بدوره بينادي على Api النتيجة اللي هترجعلي هتكون ApiResult (ممكن تكون Success أو Error)

    if (result is SuccessApiResult<MovieDetailsResponse>) {
      ///  لو النتيجة اللي رجعت من الـ RemoteDataSource كانت  Success  وكمان الداتا اللي رجعت من النوع MovieDetailsResponse

      final mapped = movieDetailsMapper.fromDataModel(
        result.data!.data!.movie!,
      );

      ///  هنا بنحول الـ Data Model (اللي جاي من API) إلى Domain Model (MovieDetailsDm) باستخدام الـ Mapper (لاحظ إننا بندخل جوا data -> movie عشان دي تركيبة الـ JSON)
      return SuccessApiResult(mapped);

      ///  هنا برجع SuccessApiResult تاني لكن المرة دي Domain Model يعني الطبقات الأعلى (Bloc, UI) هيستقبلوا Domain Model الجاهز للاستخدام
    } else if (result is ErrorApiResult) {
      ///  لو النتيجة ErrorApiResult
      return ErrorApiResult(result.myError);

      ///  هرجع نفس الـ Error اللي جالي زي ما هو
    }
    return ErrorApiResult(ServerError("Server error"));

    ///  لو النتيجة مش Success ولا Error (حاجة unexpected)
    /// هرجع ServerError عام
  }

  @override
  Future<ApiResult<List<SuggestedMovieDM>>> getMovieSuggestions(
    int movieId,
  ) async {
    ///  هنا بعمل Override لفانكشن تانية في الـ Repository دي مسئولة تجيب الأفلام المقترحة (suggestions) لفيلم معين

    final result = await _remoteDataSource.getMovieSuggestions(movieId);

    ///  هنا بنادي على الـ RemoteDataSource عشان يجيبلي الريسبونس من API

    if (result is SuccessApiResult<MovieSuggestionsResponse>) {
      ///  لو الريسبونس اللي رجع SuccessApiResult وبيحتوي MovieSuggestionsResponse

      final mappedList = movieSuggestionsMapper.fromDataModels(
        result.data!.data!.movies ?? [],
      );

      ///  هنا الـ response بيكون structured كده:
      /// data -> movies (دي ليستة الأفلام المقترحة)
      ///أنا باخد الـ movies، وبمررها على الـ Mapper
      /// عشان أحول كل SuggestedMovie (من API Model)
      /// إلى SuggestedMovieDM (من Domain Model)

      return SuccessApiResult(mappedList);

      ///  هرجع SuccessApiResult بالداتا بعد ما تحولتDomain
    } else if (result is ErrorApiResult) {
      ///  لو في Error من RemoteDataSource

      return ErrorApiResult(result.myError);

      ///  هرجع نفس الـ Error اللي موجود جوا الـ result
    }

    return ErrorApiResult(ServerError("Server error"));

    /// برضو لو حصل حاجة unexpected
  }

  @override
  Future<ApiResult<void>> toggleWatchlist({
    required MovieDetailsDm movie,
  }) async {
    try {
      // لو الفيلم موجود هيتم مسحه، لو مش موجود هيتم إضافته
      await _movieDetailsLocalDatasource.toggleWatchlist(movie);
      return SuccessApiResult(null);
    } catch (e) {
      return ErrorApiResult(UnKnownError(e.toString()));
    }
  }

  @override
  Future<ApiResult<bool>> checkWatchlist({required int movieId}) async {
    try {
      final exists = await _movieDetailsLocalDatasource.checkWatchlist(movieId);
      return SuccessApiResult(exists);
    } catch (e) {
      return ErrorApiResult(UnKnownError(e.toString()));
    }
  }

  @override
  Future<ApiResult<List<MovieDetailsDm>>> getWatchlist() async {
    try {
      final list = await _movieDetailsLocalDatasource.getWatchlist();
      return SuccessApiResult(list);
    } catch (e) {
      return ErrorApiResult(UnKnownError(e.toString()));
    }
  }
}
