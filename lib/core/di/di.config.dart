// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:firebase_auth/firebase_auth.dart' as _i59;
import 'package:get_it/get_it.dart' as _i174;
import 'package:google_sign_in/google_sign_in.dart' as _i116;
import 'package:hive/hive.dart' as _i979;
import 'package:injectable/injectable.dart' as _i526;

import '../../features_tmp/auth/data/google_services/google_sign_in_service.dart'
    as _i174;
import '../../features_tmp/auth/data/repositories/auth/auth_repository_imp.dart'
    as _i1070;
import '../../features_tmp/auth/data/repositories/auth/data_sources/auth_remote_data_source.dart'
    as _i239;
import '../../features_tmp/auth/data/repositories/auth/data_sources/auth_remote_data_source_imp.dart'
    as _i23;
import '../../features_tmp/auth/domain/repositories/auth_repository.dart'
    as _i987;
import '../../features_tmp/auth/domain/usecase/google_sign_in_usecase.dart'
    as _i112;
import '../../features_tmp/auth/domain/usecase/login_usecase.dart' as _i294;
import '../../features_tmp/auth/domain/usecase/register_usecase.dart' as _i160;
import '../../features_tmp/auth/ui/login/cubit/login_cubit.dart' as _i780;
import '../../features_tmp/auth/ui/register/cubit/register_cubit.dart' as _i225;
import '../../features_tmp/home/data/data_sources/local_data_sources/visited_movies_history_data_source_impl.dart'
    as _i1015;
import '../../features_tmp/home/data/data_sources/local_data_sources/visited_movies_history_local_data_source.dart'
    as _i508;
import '../../features_tmp/home/data/data_sources/remote_data_sources/movies_remote_data_source.dart'
    as _i549;
import '../../features_tmp/home/data/data_sources/remote_data_sources/movies_remote_data_source_impl.dart'
    as _i810;
import '../../features_tmp/home/data/mappers/movie_mapper.dart' as _i362;
import '../../features_tmp/home/data/repositories/movies_repository_impl.dart'
    as _i363;
import '../../features_tmp/home/data/repositories/visited_movies_history_repository_impl.dart'
    as _i709;
import '../../features_tmp/home/data/utils/hive_adapters/movie_adapter.dart'
    as _i328;
import '../../features_tmp/home/domain/repositories/movies_repository.dart'
    as _i383;
import '../../features_tmp/home/domain/repositories/visited_movies_history_repository.dart'
    as _i633;
import '../../features_tmp/home/domain/use_cases/add_movie_to_history_use_cse.dart'
    as _i519;
import '../../features_tmp/home/domain/use_cases/get_all_genres_use_case.dart'
    as _i136;
import '../../features_tmp/home/domain/use_cases/get_movies_by_genre_use_case.dart'
    as _i170;
import '../../features_tmp/home/domain/use_cases/get_movies_by_query_use_case.dart'
    as _i130;
import '../../features_tmp/home/domain/use_cases/get_top_rated_movies_use_case.dart'
    as _i1062;
import '../../features_tmp/home/domain/use_cases/get_visited_movie_history_use_case.dart'
    as _i226;
import '../../features_tmp/home/ui/cubits/history_cubit.dart' as _i748;
import '../../features_tmp/home/ui/cubits/movies_cubit.dart' as _i481;
import '../../features_tmp/movie_details/data/mapper/movie_details_mapper.dart'
    as _i133;
import '../../features_tmp/movie_details/data/mapper/movie_suggestions_mapper.dart'
    as _i777;
import '../../features_tmp/movie_details/data/repositories/data_source/local_datasource/movie_details_local_datasource.dart'
    as _i1053;
import '../../features_tmp/movie_details/data/repositories/data_source/local_datasource/movie_details_local_datasource_impl.dart'
    as _i788;
import '../../features_tmp/movie_details/data/repositories/data_source/remote_datasource/movie_details_remote_datasource.dart'
    as _i40;
import '../../features_tmp/movie_details/data/repositories/data_source/remote_datasource/movie_details_remote_datasource_impl.dart'
    as _i771;
import '../../features_tmp/movie_details/data/repositories/movie_details_repository_impl.dart'
    as _i759;
import '../../features_tmp/movie_details/domain/model/entites/movie_details_dm.dart'
    as _i501;
import '../../features_tmp/movie_details/domain/repositories/movie_details_repository.dart'
    as _i509;
import '../../features_tmp/movie_details/domain/usecase/movie_details_and_suggestion_usecase.dart'
    as _i118;
import '../../features_tmp/movie_details/domain/usecase/movie_watch_list_usecase.dart'
    as _i763;
import '../../features_tmp/movie_details/ui/cubit/movie_details_and_suggestion_cubit.dart'
    as _i219;
import '../../features_tmp/network/api/movie_api.dart' as _i1050;
import '../../features_tmp/network/api/movies_api_services.dart' as _i194;
import '../../features_tmp/network/api/services.dart' as _i1066;
import '../utility/app_preferences/token_storage.dart' as _i813;
import 'get_it_modules.dart' as _i320;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final getItModule = _$GetItModule();
    gh.factory<_i361.Dio>(() => getItModule.getDio());
    gh.factory<_i813.TokenStorage>(() => _i813.TokenStorage());
    gh.factory<_i362.MovieMapper>(() => _i362.MovieMapper());
    gh.factory<_i328.MovieAdapter>(() => _i328.MovieAdapter());
    gh.factory<_i133.MovieDetailsMapper>(() => _i133.MovieDetailsMapper());
    gh.factory<_i777.MovieSuggestionsMapper>(
        () => _i777.MovieSuggestionsMapper());
    gh.lazySingleton<_i59.FirebaseAuth>(() => getItModule.firebaseAuth);
    gh.lazySingleton<_i116.GoogleSignIn>(() => getItModule.googleSignIn);
    gh.factory<_i1053.MovieDetailsLocalDatasource>(() =>
        _i788.MovieDetailsLocalDataSourceImpl(
            gh<_i979.Box<_i501.MovieDetailsDm>>()));
    gh.factory<_i194.MoviesApiServices>(
        () => _i194.MoviesApiServices(gh<_i361.Dio>()));
    gh.factory<_i1050.MovieApi>(() => _i1050.MovieApi(gh<_i361.Dio>()));
    gh.factory<_i1066.Services>(() => _i1066.Services(gh<_i361.Dio>()));
    gh.factory<_i549.MoviesRemoteDataSource>(
        () => _i810.MoviesRemoteDataSourceImpl(gh<_i194.MoviesApiServices>()));
    gh.factory<_i508.VisitedMoviesHistoryLocalDataSource>(
        () => _i1015.VisitedMoviesHistoryLocalDataSourceImpl());
    gh.factory<_i633.VisitedMoviesHistoryRepository>(
        () => _i709.VisitedMoviesHistoryRepositoryImpl(
              gh<_i362.MovieMapper>(),
              gh<_i508.VisitedMoviesHistoryLocalDataSource>(),
            ));
    gh.lazySingleton<_i174.GoogleSignInService>(() => _i174.GoogleSignInService(
          googleSignIn: gh<_i116.GoogleSignIn>(),
          firebaseAuth: gh<_i59.FirebaseAuth>(),
        ));
    gh.factory<_i383.MoviesRepository>(() => _i363.MoviesRepositoryImpl(
          gh<_i549.MoviesRemoteDataSource>(),
          gh<_i362.MovieMapper>(),
        ));
    gh.factory<_i40.MovieDetailsRemoteDataSource>(
        () => _i771.MovieDetailsRemoteDataSourceImpl(gh<_i1050.MovieApi>()));
    gh.factory<_i519.AddMovieToHistoryUseCase>(() =>
        _i519.AddMovieToHistoryUseCase(
            gh<_i633.VisitedMoviesHistoryRepository>()));
    gh.factory<_i226.GetVisitedMovieHistoryUseCase>(() =>
        _i226.GetVisitedMovieHistoryUseCase(
            gh<_i633.VisitedMoviesHistoryRepository>()));
    gh.factory<_i136.GetAllGenresUseCase>(
        () => _i136.GetAllGenresUseCase(gh<_i383.MoviesRepository>()));
    gh.factory<_i170.GetMoviesByGenreUseCase>(
        () => _i170.GetMoviesByGenreUseCase(gh<_i383.MoviesRepository>()));
    gh.factory<_i130.GetMoviesByQueryUseCase>(
        () => _i130.GetMoviesByQueryUseCase(gh<_i383.MoviesRepository>()));
    gh.factory<_i1062.GetTopRatedMoviesUseCase>(
        () => _i1062.GetTopRatedMoviesUseCase(gh<_i383.MoviesRepository>()));
    gh.factory<_i239.AuthRemoteDataSource>(
        () => _i23.AuthRemoteDataSourceImp(gh<_i1066.Services>()));
    gh.factory<_i509.MovieDetailsRepository>(
        () => _i759.MovieDetailsRepositoryImpl(
              gh<_i40.MovieDetailsRemoteDataSource>(),
              gh<_i133.MovieDetailsMapper>(),
              gh<_i777.MovieSuggestionsMapper>(),
              gh<_i1053.MovieDetailsLocalDatasource>(),
            ));
    gh.factory<_i987.AuthRepository>(() => _i1070.AuthRepositoryImp(
          gh<_i239.AuthRemoteDataSource>(),
          gh<_i174.GoogleSignInService>(),
        ));
    gh.factory<_i748.HistoryCubit>(() => _i748.HistoryCubit(
          gh<_i226.GetVisitedMovieHistoryUseCase>(),
          gh<_i519.AddMovieToHistoryUseCase>(),
        ));
    gh.factory<_i481.MoviesCubit>(() => _i481.MoviesCubit(
          gh<_i1062.GetTopRatedMoviesUseCase>(),
          gh<_i170.GetMoviesByGenreUseCase>(),
          gh<_i130.GetMoviesByQueryUseCase>(),
          gh<_i136.GetAllGenresUseCase>(),
        ));
    gh.factory<_i160.RegisterUseCase>(
        () => _i160.RegisterUseCase(gh<_i987.AuthRepository>()));
    gh.factory<_i118.MovieDetailsUseCase>(
        () => _i118.MovieDetailsUseCase(gh<_i509.MovieDetailsRepository>()));
    gh.factory<_i118.MovieSuggestionUseCase>(
        () => _i118.MovieSuggestionUseCase(gh<_i509.MovieDetailsRepository>()));
    gh.factory<_i763.MovieWatchlistUseCase>(
        () => _i763.MovieWatchlistUseCase(gh<_i509.MovieDetailsRepository>()));
    gh.factory<_i294.LoginUseCase>(
        () => _i294.LoginUseCase(gh<_i987.AuthRepository>()));
    gh.factory<_i219.MovieDetailsAndSuggestionCubit>(
        () => _i219.MovieDetailsAndSuggestionCubit(
              gh<_i118.MovieDetailsUseCase>(),
              gh<_i118.MovieSuggestionUseCase>(),
              gh<_i763.MovieWatchlistUseCase>(),
            ));
    gh.factory<_i225.RegisterCubit>(
        () => _i225.RegisterCubit(gh<_i160.RegisterUseCase>()));
    gh.factory<_i112.GoogleSignInUseCase>(
        () => _i112.GoogleSignInUseCase(gh<_i987.AuthRepository>()));
    gh.factory<_i780.LoginCubit>(() => _i780.LoginCubit(
          gh<_i294.LoginUseCase>(),
          gh<_i112.GoogleSignInUseCase>(),
        ));
    return this;
  }
}

class _$GetItModule extends _i320.GetItModule {}
