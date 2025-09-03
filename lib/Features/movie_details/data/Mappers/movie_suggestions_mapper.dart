import 'package:injectable/injectable.dart';

import '../../domain/model/entites/movie_suggestions_dm.dart';
import '../model/movie_suggestions_response.dart';

@injectable  /// دا عشان يعرف ال MovieSuggestionsMapper عند ال get it
class MovieSuggestionsMapper { /// انا هنا ممكن اعملوا علي ال chatgpt بتاخد الكلاس بتاع ال domain source وكلاس ال data ال هوا sourceResponse وتحطهم في chatgpt   بس انا عملت كدا عشان افهم
  SuggestedMovieDM fromDataModel(SuggestedMovie movie) { ///دية هتاخد ال SuggestedMovie دا الي جواة  MovieSuggestionsResponse  ترجعوا علي انوا SuggestedMovieDM الي جي من ال domain
    return SuggestedMovieDM(
      id: movie.id ?? 0,
      title: movie.title ?? "",
      titleEnglish: movie.titleEnglish,
      titleLong: movie.titleLong,
      year: movie.year ?? 0,
      rating: movie.rating ?? 0.0,
      runtime: movie.runtime ?? 0,
      genres: movie.genres ?? [],
      summary: movie.summary,
      ytTrailerCode: movie.ytTrailerCode,
      backgroundImage: movie.backgroundImage,
      coverImage: movie.mediumCoverImage, /// اخترت الـ mediumCoverImage كـ cover
    );
  }

  List<SuggestedMovieDM> fromDataModels(List<SuggestedMovie> movies) { /// دية هتاخد ليستة من ال SuggestedMovie دا الي جواة  MovieSuggestionsResponse  ترجعهولي علي انو ليست من ال SuggestedMovieDM
    return movies.map(fromDataModel).toList();
  }
}