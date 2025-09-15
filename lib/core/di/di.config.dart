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

import '../../features/auth/data/google_services/google_sign_in_service.dart'
    as _i960;
import '../../features/auth/data/repositories/auth/auth_repository_imp.dart'
    as _i85;
import '../../features/auth/data/repositories/auth/data_sources/auth_remote_data_source.dart'
    as _i61;
import '../../features/auth/data/repositories/auth/data_sources/auth_remote_data_source_imp.dart'
    as _i693;
import '../../features/auth/domain/repositories/auth_repository.dart' as _i787;
import '../../features/auth/domain/usecase/google_sign_in_usecase.dart'
    as _i310;
import '../../features/auth/domain/usecase/login_usecase.dart' as _i911;
import '../../features/auth/domain/usecase/register_usecase.dart' as _i769;
import '../../features/auth/ui/login/cubit/login_cubit.dart' as _i416;
import '../../features/auth/ui/register/cubit/register_cubit.dart' as _i539;
import '../../features/data/mapper/movie_details_mapper.dart' as _i1017;
import '../../features/data/mapper/movie_suggestions_mapper.dart' as _i908;
import '../../features/data/repositories/data_source/local_datasource/movie_details_local_datasource.dart'
    as _i432;
import '../../features/data/repositories/data_source/local_datasource/movie_details_local_datasource_impl.dart'
    as _i82;
import '../../features/data/repositories/data_source/remote_datasource/movie_details_remote_datasource.dart'
    as _i1060;
import '../../features/data/repositories/data_source/remote_datasource/movie_details_remote_datasource_impl.dart'
    as _i766;
import '../../features/data/repositories/movie_details_repository_impl.dart'
    as _i761;
import '../../features/domain/model/entites/movie_details_dm.dart' as _i252;
import '../../features/domain/repositories/movie_details_repository.dart'
    as _i389;
import '../../features/domain/usecase/movie_details_and_suggestion_usecase.dart'
    as _i1013;
import '../../features/domain/usecase/movie_watch_list_usecase.dart' as _i2;
import '../../features/network/api/movie_api.dart' as _i561;
import '../../features/network/api/services.dart' as _i63;
import '../../features/ui/cubit/movie_details_and_suggestion_cubit.dart'
    as _i66;
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
    gh.factory<_i1017.MovieDetailsMapper>(() => _i1017.MovieDetailsMapper());
    gh.factory<_i908.MovieSuggestionsMapper>(
        () => _i908.MovieSuggestionsMapper());
    gh.lazySingleton<_i59.FirebaseAuth>(() => getItModule.firebaseAuth);
    gh.lazySingleton<_i116.GoogleSignIn>(() => getItModule.googleSignIn);
    gh.factory<_i561.MovieApi>(() => _i561.MovieApi(gh<_i361.Dio>()));
    gh.factory<_i63.Services>(() => _i63.Services(gh<_i361.Dio>()));
    gh.factory<_i1060.MovieDetailsRemoteDataSource>(
        () => _i766.MovieDetailsRemoteDataSourceImpl(gh<_i561.MovieApi>()));
    gh.lazySingleton<_i960.GoogleSignInService>(() => _i960.GoogleSignInService(
          googleSignIn: gh<_i116.GoogleSignIn>(),
          firebaseAuth: gh<_i59.FirebaseAuth>(),
        ));
    gh.factory<_i432.MovieDetailsLocalDatasource>(() =>
        _i82.MovieDetailsLocalDataSourceImpl(
            gh<_i979.Box<_i252.MovieDetailsDm>>()));
    gh.factory<_i61.AuthRemoteDataSource>(
        () => _i693.AuthRemoteDataSourceImp(gh<_i63.Services>()));
    gh.factory<_i787.AuthRepository>(() => _i85.AuthRepositoryImp(
          gh<_i61.AuthRemoteDataSource>(),
          gh<_i960.GoogleSignInService>(),
        ));
    gh.factory<_i389.MovieDetailsRepository>(
        () => _i761.MovieDetailsRepositoryImpl(
              gh<_i1060.MovieDetailsRemoteDataSource>(),
              gh<_i1017.MovieDetailsMapper>(),
              gh<_i908.MovieSuggestionsMapper>(),
              gh<_i432.MovieDetailsLocalDatasource>(),
            ));
    gh.factory<_i769.RegisterUseCase>(
        () => _i769.RegisterUseCase(gh<_i787.AuthRepository>()));
    gh.factory<_i911.LoginUseCase>(
        () => _i911.LoginUseCase(gh<_i787.AuthRepository>()));
    gh.factory<_i1013.MovieDetailsUseCase>(
        () => _i1013.MovieDetailsUseCase(gh<_i389.MovieDetailsRepository>()));
    gh.factory<_i1013.MovieSuggestionUseCase>(() =>
        _i1013.MovieSuggestionUseCase(gh<_i389.MovieDetailsRepository>()));
    gh.factory<_i2.MovieWatchlistUseCase>(
        () => _i2.MovieWatchlistUseCase(gh<_i389.MovieDetailsRepository>()));
    gh.factory<_i539.RegisterCubit>(
        () => _i539.RegisterCubit(gh<_i769.RegisterUseCase>()));
    gh.factory<_i310.GoogleSignInUseCase>(
        () => _i310.GoogleSignInUseCase(gh<_i787.AuthRepository>()));
    gh.factory<_i416.LoginCubit>(() => _i416.LoginCubit(
          gh<_i911.LoginUseCase>(),
          gh<_i310.GoogleSignInUseCase>(),
        ));
    gh.factory<_i66.MovieDetailsAndSuggestionCubit>(
        () => _i66.MovieDetailsAndSuggestionCubit(
              gh<_i1013.MovieDetailsUseCase>(),
              gh<_i1013.MovieSuggestionUseCase>(),
              gh<_i2.MovieWatchlistUseCase>(),
            ));
    return this;
  }
}

class _$GetItModule extends _i320.GetItModule {}
