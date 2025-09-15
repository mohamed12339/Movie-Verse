import 'package:injectable/injectable.dart';
import 'package:project_movie_app/core/api_result/api_result.dart';
import 'package:project_movie_app/features_tmp/auth/data/repositories/auth/data_sources/auth_remote_data_source.dart';
import 'package:project_movie_app/features_tmp/network/api/services.dart';
import 'package:project_movie_app/features_tmp/network/model/request/login_request/login_request.dart';
import 'package:project_movie_app/features_tmp/network/model/request/register_request/register_request.dart';
import 'package:project_movie_app/features_tmp/network/model/response/login_response/login_response.dart';
import 'package:project_movie_app/features_tmp/network/model/response/register_response/register_response.dart';

@Injectable(as: AuthRemoteDataSource)
class AuthRemoteDataSourceImp extends AuthRemoteDataSource {
  Services _apiServices;

  AuthRemoteDataSourceImp(this._apiServices);

  @override
  Future<ApiResult<LoginResponse>> login(LoginRequest request) async {
    try {
      final response = await _apiServices.login(request); // LoginResponse
      return SuccessApiResult(response);
    } catch (e) {
      return ErrorApiResult(ServerError(e.toString()));
    }
  }

  @override
  Future<ApiResult<RegisterResponse>> register(RegisterRequest request) async {
    try {
      final response = await _apiServices.register(request);
      return SuccessApiResult(response);
    } catch (e) {
      return ErrorApiResult(ServerError(e.toString()));
    }
  }
}
