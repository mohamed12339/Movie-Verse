import 'package:hive_flutter/adapters.dart';
import 'package:movies/features/home/domain/models/movie.dart';

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
  int get typeId => 1;
}