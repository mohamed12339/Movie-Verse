import 'package:hive_flutter/adapters.dart';
import 'package:injectable/injectable.dart';
import 'package:project_movie_app/features_tmp/home/data/data_sources/local_data_sources/visited_movies_history_local_data_source.dart';
import 'package:project_movie_app/features_tmp/home/domain/models/movie.dart';


@Injectable(as: VisitedMoviesHistoryLocalDataSource)
class VisitedMoviesHistoryLocalDataSourceImpl extends VisitedMoviesHistoryLocalDataSource {

  @override
  Future<void> addMovieToHistory(Movie movie) async {
    var box = await Hive.openBox<Movie>("history");

    // remove old instance if exists
    if (box.containsKey(movie.id)) {
      await box.delete(movie.id);
    }

    await box.put(movie.id, movie);
  }

  @override
  Future<List<Movie>> getVisitedMoviesHistory() async {
    var box = await Hive.openBox<Movie>("history");
    return box.values.toList();
  }
}