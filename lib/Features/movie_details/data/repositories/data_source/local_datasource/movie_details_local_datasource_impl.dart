import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';
import 'package:project_movie_app/Features/movie_details/data/repositories/data_source/local_datasource/movie_details_local_datasource.dart';
import 'package:project_movie_app/Features/movie_details/domain/model/entites/movie_details_dm.dart';

@Injectable(as: MovieDetailsLocalDatasource)
class MovieDetailsLocalDataSourceImpl extends MovieDetailsLocalDatasource { /// دا الداتا الاوفلاين
  /// انتا ممكن تستخدم package sqllite ودية مش قوية الاحسن hive وممكن بردو FirebaseFirestore ودية جامدة جدا بردو وانزل packege منها اسمها accessdataoffline


  final Box<MovieDetailsDm> watchlistBox;
  MovieDetailsLocalDataSourceImpl(this.watchlistBox);  /// الـ box هيجي من DI (getIt)

  @override
  Future<void> toggleWatchlist(MovieDetailsDm movie) async {
    if (watchlistBox.containsKey(movie.id)) {  /// دا بقولوا اني بتاكد ان لو الفيلم موجود ولا لا طب لو موجود اعمل دا الي تحت
      await watchlistBox.delete(movie.id);  /// لو الفيلم موجود → خزنوا
    } else {
      await watchlistBox.put(movie.id, movie);  /// لو مش موجود → خزنه
    }
  }

  @override
  Future<bool> checkWatchlist(int movieId) async {

    return watchlistBox.containsKey(movieId);  /// هنا بقا ب check لو الفيلم موجود ولا لا لو موجود خلاص يبقا اتخزن وتقدر تمسحوا لو مش موجود لا خزنوا بقا
  }

  @override
  Future<List<MovieDetailsDm>> getWatchlist() async {
    return watchlistBox.values.toList(); /// بجيب كل الافلام واخزنها في ليستة
  }
}