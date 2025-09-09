// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../../features/home/data/data_sources/local_data_sources/visited_movies_history_data_source_impl.dart'
    as _i420;
import '../../features/home/data/data_sources/local_data_sources/visited_movies_history_local_data_source.dart'
    as _i958;
import '../../features/home/data/data_sources/remote_data_sources/movies_remote_data_source.dart'
    as _i993;
import '../../features/home/data/data_sources/remote_data_sources/movies_remote_data_source_impl.dart'
    as _i162;
import '../../features/home/data/mappers/movie_mapper.dart' as _i900;
import '../../features/home/data/repositories/movies_repository_impl.dart'
    as _i738;
import '../../features/home/data/repositories/visited_movies_history_repository_impl.dart'
    as _i845;
import '../../features/home/domain/repositories/movies_repository.dart'
    as _i936;
import '../../features/home/domain/repositories/visited_movies_history_repository.dart'
    as _i74;
import '../../features/home/domain/use_cases/add_movie_to_history_use_cse.dart'
    as _i155;
import '../../features/home/domain/use_cases/get_all_genres_use_case.dart'
    as _i411;
import '../../features/home/domain/use_cases/get_movies_by_genre_use_case.dart'
    as _i460;
import '../../features/home/domain/use_cases/get_movies_by_query_use_case.dart'
    as _i236;
import '../../features/home/domain/use_cases/get_top_rated_movies_use_case.dart'
    as _i113;
import '../../features/home/domain/use_cases/get_visited_movie_history_use_case.dart'
    as _i184;
import '../../features/home/network/api/movies_api_services.dart' as _i671;
import '../../features/home/ui/cubits/history_cubit.dart' as _i68;
import '../../features/home/ui/cubits/movies_cubit.dart' as _i603;
import 'get_it_modules.dart' as _i320;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final getItModule = _$GetItModule();
    gh.factory<_i361.Dio>(() => getItModule.getDio());
    gh.factory<_i900.MovieMapper>(() => _i900.MovieMapper());
    gh.factory<_i671.MoviesApiServices>(
      () => _i671.MoviesApiServices.new(gh<_i361.Dio>()),
    );
    gh.factory<_i958.VisitedMoviesHistoryLocalDataSource>(
      () => _i420.VisitedMoviesHistoryLocalDataSourceImpl(),
    );
    gh.factory<_i74.VisitedMoviesHistoryRepository>(
      () => _i845.VisitedMoviesHistoryRepositoryImpl(
        gh<_i900.MovieMapper>(),
        gh<_i958.VisitedMoviesHistoryLocalDataSource>(),
      ),
    );
    gh.factory<_i155.AddMovieToHistoryUseCase>(
      () => _i155.AddMovieToHistoryUseCase(
        gh<_i74.VisitedMoviesHistoryRepository>(),
      ),
    );
    gh.factory<_i184.GetVisitedMovieHistoryUseCase>(
      () => _i184.GetVisitedMovieHistoryUseCase(
        gh<_i74.VisitedMoviesHistoryRepository>(),
      ),
    );
    gh.factory<_i993.MoviesRemoteDataSource>(
      () => _i162.MoviesRemoteDataSourceImpl(gh<_i671.MoviesApiServices>()),
    );
    gh.factory<_i68.HistoryCubit>(
      () => _i68.HistoryCubit(
        gh<_i184.GetVisitedMovieHistoryUseCase>(),
        gh<_i155.AddMovieToHistoryUseCase>(),
      ),
    );
    gh.factory<_i936.MoviesRepository>(
      () => _i738.MoviesRepositoryImpl(
        gh<_i993.MoviesRemoteDataSource>(),
        gh<_i900.MovieMapper>(),
      ),
    );
    gh.factory<_i411.GetAllGenresUseCase>(
      () => _i411.GetAllGenresUseCase(gh<_i936.MoviesRepository>()),
    );
    gh.factory<_i460.GetMoviesByGenreUseCase>(
      () => _i460.GetMoviesByGenreUseCase(gh<_i936.MoviesRepository>()),
    );
    gh.factory<_i236.GetMoviesByQueryUseCase>(
      () => _i236.GetMoviesByQueryUseCase(gh<_i936.MoviesRepository>()),
    );
    gh.factory<_i113.GetTopRatedMoviesUseCase>(
      () => _i113.GetTopRatedMoviesUseCase(gh<_i936.MoviesRepository>()),
    );
    gh.factory<_i603.MoviesCubit>(
      () => _i603.MoviesCubit(
        gh<_i113.GetTopRatedMoviesUseCase>(),
        gh<_i460.GetMoviesByGenreUseCase>(),
        gh<_i236.GetMoviesByQueryUseCase>(),
        gh<_i411.GetAllGenresUseCase>(),
      ),
    );
    return this;
  }
}

class _$GetItModule extends _i320.GetItModule {}
