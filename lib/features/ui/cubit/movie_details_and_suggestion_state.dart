import '../../../../core/api_result/api_result.dart';
import '../../domain/model/entites/movie_details_dm.dart';
import '../../domain/model/entites/movie_suggestions_dm.dart';


class MovieDetailsAndSuggestionState { /// دا الـ state اللي هيحتفظ بالـ data والحالات (Initial, Loading, Success, Error) وهابتعها لل cubit

  late ApiResult<MovieDetailsDm> movieDetailsApi; /// هنا بنخزن حالة تفاصيل الفيلم


  late ApiResult<List<SuggestedMovieDM>> movieSuggestionApi; /// هنا بنخزن حالة الأفلام المقترحة

  late ApiResult<List<MovieDetailsDm>> watchListApi;  /// هنا بنخزن تفاصيل الفيلم في ال watchList بتاعة الايكون

  late ApiResult<bool> isInWatchListApi; /// ودية بتعمل check علي انو موجود ولا لا

  MovieDetailsAndSuggestionState({ /// constructor اساسي بياخد القيم المطلوبة
    required this.movieDetailsApi,
    required this.movieSuggestionApi,
    required this.watchListApi,
    required this.isInWatchListApi
  });


 MovieDetailsAndSuggestionState.initial() {  /// والي هابعتها لل super  (الحالة الابتدائية قبل ما نجيب أي بيانات) initial state
      movieDetailsApi = InitialApiResult();   /// كل حاجة لسه فاضية، قبل أي تحميل
      movieSuggestionApi = InitialApiResult();  /// كل حاجة لسه فاضية، قبل أي تحميل
      watchListApi = InitialApiResult(); /// كل حاجة لسه فاضية، قبل أي تحميل
      isInWatchListApi =  InitialApiResult(); /// كل حاجة لسه فاضية، قبل أي تحميل
  }


  MovieDetailsAndSuggestionState copyWith({  /// زي ال colors لما بقولوا غير الحتة بس بلون كزا فا ال  copyWith بتسهل علينا تحديث الـ state من غير ما نغير القديم كله
    ApiResult<MovieDetailsDm>? movieDetailsApi, /// انا هنا بقولوا الي هاتغير مين دلوقتي movieDetailsApi وممكن تبقا ب null بردوا
    ApiResult<List<SuggestedMovieDM>>? movieSuggestionApi, /// انا هنا بقولوا الي هاتغير مين دلوقتي movieSuggestionApi وممكن تبقا ب null بردوا
    ApiResult<List<MovieDetailsDm>>? watchListApi , /// انا هنا بقولوا الي هاتغير مين دلوقتي watchList وممكن تبقا ب null بردوا
    ApiResult<bool>? isInWatchListApi,
  }) {
    return MovieDetailsAndSuggestionState(
      movieDetailsApi: movieDetailsApi ?? this.movieDetailsApi,         /// لو جاب فيلم جديد استخدمها ، غير كده خلي القديم
      movieSuggestionApi: movieSuggestionApi ?? this.movieSuggestionApi, /// نفس الفكرة للأفلام المقترحة
        watchListApi: watchListApi ?? this.watchListApi,  /// لو داس علي فيلم جديد استخدمها ، غير كده خلي القديم
      isInWatchListApi: isInWatchListApi ?? this.isInWatchListApi

    );
  }
}