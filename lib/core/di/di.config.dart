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

import '../../Features/movie_details/data/Mappers/movie_details_mapper.dart'
    as _i260;
import '../../Features/movie_details/data/Mappers/movie_suggestions_mapper.dart'
    as _i523;
import '../../Features/movie_details/data/repositories/data_source/movie_details_remote_datasource.dart'
    as _i255;
import '../../Features/movie_details/data/repositories/data_source/movie_details_remote_datasource_impl.dart'
    as _i851;
import '../../Features/movie_details/data/repositories/movie_details_repository_impl.dart'
    as _i471;
import '../../Features/movie_details/domain/repositories/movie_details_repository.dart'
    as _i402;
import '../../Features/movie_details/domain/usecase/movie_details_and_suggestion_usecase.dart'
    as _i1028;
import '../../Features/movie_details/domain/usecase/movie_watch_list_usecase.dart'
    as _i698;
import '../../Features/movie_details/network/api/movie_api.dart' as _i551;
import '../../Features/movie_details/ui/cubit/movie_details_and_suggestion_cubit.dart'
    as _i183;
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
    gh.factory<_i260.MovieDetailsMapper>(() => _i260.MovieDetailsMapper());
    gh.factory<_i523.MovieSuggestionsMapper>(
      () => _i523.MovieSuggestionsMapper(),
    );
    gh.factory<_i551.MovieApi>(() => _i551.MovieApi.new(gh<_i361.Dio>()));
    gh.factory<_i255.MovieDetailsRemoteDataSource>(
      () => _i851.MovieDetailsRemoteDataSourceImpl(gh<_i551.MovieApi>()),
    );
    gh.factory<_i402.MovieDetailsRepository>(
      () => _i471.MovieDetailsRepositoryImpl(
        gh<_i255.MovieDetailsRemoteDataSource>(),
        gh<_i260.MovieDetailsMapper>(),
        gh<_i523.MovieSuggestionsMapper>(),
      ),
    );
    gh.factory<_i1028.MovieDetailsUseCase>(
      () => _i1028.MovieDetailsUseCase(gh<_i402.MovieDetailsRepository>()),
    );
    gh.factory<_i1028.MovieSuggestionUseCase>(
      () => _i1028.MovieSuggestionUseCase(gh<_i402.MovieDetailsRepository>()),
    );
    gh.factory<_i698.MovieWatchlistUseCase>(
      () => _i698.MovieWatchlistUseCase(gh<_i402.MovieDetailsRepository>()),
    );
    gh.factory<_i183.MovieDetailsAndSuggestionCubit>(
      () => _i183.MovieDetailsAndSuggestionCubit(
        gh<_i1028.MovieDetailsUseCase>(),
        gh<_i1028.MovieSuggestionUseCase>(),
        gh<_i698.MovieWatchlistUseCase>(),
      ),
    );
    return this;
  }
}

class _$GetItModule extends _i320.GetItModule {}
