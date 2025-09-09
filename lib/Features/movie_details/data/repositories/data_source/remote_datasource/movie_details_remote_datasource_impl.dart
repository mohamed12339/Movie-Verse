import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import '../../../../../../core/api_result/api_result.dart';
import '../../../../network/api/movie_api.dart';
import '../../../model/movie_details_response.dart';
import '../../../model/movie_suggestions_response.dart';
import 'movie_details_remote_datasource.dart';

@Injectable(as: MovieDetailsRemoteDataSource) /// اهم حاجة انا مستخدم Injectable الي هيا بال I كدا عشان  دية انا عملتها عشان اقولوا لو طلبت abstract class دا   (as: MovieDetailsRemoteDataSource) دا ابعتلي child ال (MovieDetailsRemoteDataSourceImpl) بتاعوا زي ال news كدا لما عملتها في get it فايل بالظبط  بس هنا بقا هايعملها لوحدوا generated
class MovieDetailsRemoteDataSourceImpl extends MovieDetailsRemoteDataSource { /// فايدة حتة الي impl واعمل extend لل abstract class بتاعها هيا ال coupling  يعني لو حصل تغير فا انتا مثلا تغير في كلاس impl مش هايحصل حاجة لل abstract كلاس خالص ودا فايدتوا ان لو حصل تغير في ال project هنغير حاجة مثلا تروح تغيرها في ال impl2 وهيا كدا كدا هتسمع في ال abstract class و ال impl1  لانها فانكشن فاضية بس بتعملها override من عند ال impl 1 and 2 بس فا بتغير هناك بس انا مش عامل impl2 ليها بس
  final MovieApi api;  ///انا بعتللك ال api اهو وعملتلو كونستراكتور

  MovieDetailsRemoteDataSourceImpl(this.api);

  @override
  Future<ApiResult<MovieDetailsResponse>> getMovieDetails(int movieId) async { /// انا هنا بقولوا رجعلي apiResults عشان لو فية ايرور كدا فهل هيبقا success or error or loading or initial  وكمان هيا مش هترجع api result بس لا هترجعوا علي انو MovieDetailsResponse ودية فايدة tempelete الي عملتها هناك في ال apiResult الانا عملتها هناك
    const withImages = true ; /// بعتلوا دول لية عشان ال screen shot تظهر وال cast يظهر برضو بس كدا
    const   withCast = true ;
    try {
      final response = await api.getMovieDetails(movieId ,  withCast , withImages);
      return SuccessApiResult(response.data); /// انا هنا بندة ال api بتاع ال  login وال retrofit package هاتكمل بقا ودية حلاوتها لانها عاملة genetrated لوحدها من عن طرق تكتب في ال terminal dart pub run build_runner build بس كدا وهيا تعمل api login هتلاقية معمول عندها في الفايل بتاعها وكمان رجعتها كا successApiResult
    }on DioException catch(e){
      return ErrorApiResult(NetworkError(e.message ?? "Network error")); /// لو الايرور يبقا نت يظهروا
    } catch (e) {
      return ErrorApiResult(ServerError(e.toString())); /// او لو العيب في السيرفر نفسوا برضو
    }
  }

  @override
  Future<ApiResult<MovieSuggestionsResponse>> getMovieSuggestions(int movieId) async { ///نفس الكلام بردو بتاع سطر 14
    try {
      final response = await api.getMovieSuggestions(movieId);
      return SuccessApiResult(response.data);/// هنا انا بردو بندة علي ال api بتاع ال register وبردو نفس الكلام بتاع سطر 21
    }on DioException catch(e){
      return ErrorApiResult(NetworkError(e.message ?? "Network error")); /// لو الايرور يبقا نت يظهروا
    } catch (e) {
      return ErrorApiResult(ServerError(e.toString()));  /// او لو العيب في السيرفر نفسوا برضو
    }
  }
}