import 'package:injectable/injectable.dart';
import 'package:project_movie_app/features_tmp/home/data/models/list_movies_response.dart';
import 'package:project_movie_app/features_tmp/home/domain/models/movie.dart';


@injectable
class MovieMapper{
  Movie fromDataModel(MovieDM movie){
    return Movie(id: movie.id ?? 0, rating: movie.rating ?? 0, largeCoverImage: movie.largeCoverImage ?? '');
  }

  List<Movie> fromDataModelList(List<MovieDM> movies){
    return movies.map((movie) => fromDataModel(movie)).toList();
  }
}