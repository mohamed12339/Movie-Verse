import 'package:hive_flutter/adapters.dart';
import 'package:injectable/injectable.dart';
import 'package:project_movie_app/features_tmp/home/domain/models/movie.dart';

@injectable
class MovieAdapter extends TypeAdapter<Movie> {
  @override
  Movie read(BinaryReader reader) {
   var json = reader.readMap();
    return Movie.fromJson(json);
  }
@override
  void write(BinaryWriter writer, Movie obj) {
    writer.writeMap(obj.toJson());
  }

  @override
  // TODO: implement typeId
  int get typeId => 4;
}