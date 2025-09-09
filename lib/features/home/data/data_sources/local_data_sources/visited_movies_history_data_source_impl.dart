import 'package:hive_flutter/adapters.dart';
import 'package:injectable/injectable.dart';
import 'package:movies/features/home/data/data_sources/local_data_sources/visited_movies_history_local_data_source.dart';
import 'package:movies/features/home/domain/models/movie.dart';

@Injectable(as: VisitedMoviesHistoryLocalDataSource)
class VisitedMoviesHistoryLocalDataSourceImpl
    implements VisitedMoviesHistoryLocalDataSource {
  @override
  Future<void> addMovieToHistory(Movie movie) async {
    var box = await Hive.openBox<List<Movie>>("history");
    List<Movie> movies = box.get("movies", defaultValue: []) ?? [];

    // remove old instance if exists
    movies.removeWhere((m) => m.id == movie.id);

    // add at the end
    movies.add(movie);

    await box.put("movies", movies);
  }

  @override
  Future<List<Movie>> getVisitedMoviesHistory() async {
    var box = await Hive.openBox<List<Movie>>("history");
    List<Movie> movies = box.get("movies", defaultValue: []) ?? [];
    return movies;
  }
}
