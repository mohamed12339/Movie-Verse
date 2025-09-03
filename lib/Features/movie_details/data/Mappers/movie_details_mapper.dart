import 'package:injectable/injectable.dart';

import '../../domain/model/entites/movie_details_dm.dart';
import '../model/movie_details_response.dart';

@injectable /// دا عشان يعرف ال MovieDetailsMapper عند ال get it
class MovieDetailsMapper { /// انا هنا ممكن اعملوا علي ال chatgpt بتاخد الكلاس بتاع ال domain source وكلاس ال data ال هوا sourceResponse وتحطهم في chatgpt   بس انا عملت كدا عشان افهم
  MovieDetailsDm fromDataModel(Movie movie) { ///دية هتاخد ال Movie دا الي جواة  moviedetailsresponse  ترجعوا علي انوا MovieDetailsDm الي جي من ال domain
    return MovieDetailsDm(
      id: movie.id ?? 0,
      title: movie.title ?? "",
      year: movie.year ?? 0,
      rating: movie.rating ?? 0.0,
      runtime: movie.runtime ?? 0,
      genres: movie.genres ?? [],
      description: movie.descriptionFull ?? "",
      ytTrailerCode: movie.ytTrailerCode ?? "",
      language: movie.language ?? "",
      mpaRating: movie.mpaRating ?? "",
      backgroundImage: movie.backgroundImage ?? "",
      largeCoverImage: movie.largeCoverImage ?? "",
      cast: movie.cast?.map((c) => CastEntity(
        name: c.name ?? "",
        characterName: c.characterName,
        imageUrl: c.urlSmallImage,
      )).toList() ?? [],
      torrents: movie.torrents?.map((t) => TorrentEntity(
        quality: t.quality ?? "",
        type: t.type ?? "",
        size: t.size ?? "",
        seeds: t.seeds ?? 0,
        peers: t.peers ?? 0,
      )).toList() ?? [],
    );
  }

  List<MovieDetailsDm> fromDataModels(List<Movie> movies) { /// دية هتاخد ليستة من ال Movie دا الي جواة  moviedetailsresponse  ترجعهولي علي انو ليست من ال MovieDetailsDm
    return movies.map(fromDataModel).toList();
  }
}