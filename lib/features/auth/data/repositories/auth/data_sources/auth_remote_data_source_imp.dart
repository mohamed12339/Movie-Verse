import 'package:injectable/injectable.dart';
import 'package:project_movie_app/core/api_result/api_result.dart';
import 'package:project_movie_app/features/auth/data/repositories/auth/data_sources/auth_remote_data_source.dart';
import 'package:project_movie_app/features/network/api/services.dart';
import 'package:project_movie_app/features/network/model/request/login_request/login_request.dart';
import 'package:project_movie_app/features/network/model/request/register_request/register_request.dart';
import 'package:project_movie_app/features/network/model/response/token_response/token_response.dart';

@Injectable(as: AuthRemoteDataSource)
class AuthRemoteDataSourceImp extends AuthRemoteDataSource {
  Services _apiServices;

  AuthRemoteDataSourceImp(this._apiServices);

  @override
  Future<ApiResult<TokenResponse>> login(LoginRequest request) async {
    try {
      return SuccessApiResult(await _apiServices.login(request));
    } catch (e) {
      return ErrorApiResult(ServerError(e.toString()));
    }
  }

  @override
  Future<ApiResult<TokenResponse>> register(RegisterRequest request) async {
    try {
      return SuccessApiResult(await _apiServices.register(request));
    } catch (e) {
      return ErrorApiResult(ServerError(e.toString()));
    }
  }
}
