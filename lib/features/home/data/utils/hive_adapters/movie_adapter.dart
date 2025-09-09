import 'package:hive_flutter/adapters.dart';
<<<<<<< Updated upstream
import 'package:movies/features/home/data/models/list_movies_response.dart';

class MovieDMAdapter extends TypeAdapter<MovieDM>{
  @override
  MovieDM read(BinaryReader reader) {
    Map<String,dynamic> json = reader.readMap() as Map<String,dynamic>;
    return MovieDM.fromJson(json);
=======
import 'package:movies/features/home/domain/models/movie.dart';

class MovieAdapter extends TypeAdapter<Movie>{
  @override
  Movie read(BinaryReader reader) {
    Map<String,dynamic> json = reader.readMap() as Map<String,dynamic>;
    return Movie.fromJson(json);
>>>>>>> Stashed changes
  }

  @override
  int get typeId => 1;

  @override
<<<<<<< Updated upstream
  void write(BinaryWriter writer, MovieDM obj) {
=======
  void write(BinaryWriter writer, Movie obj) {
>>>>>>> Stashed changes
    writer.writeMap(obj.toJson());
  }

}