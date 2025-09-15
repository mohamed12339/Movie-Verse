import 'package:project_movie_app/core/api_result/api_result.dart';
import 'package:project_movie_app/features_tmp/network/model/request/login_request/login_request.dart';
import 'package:project_movie_app/features_tmp/network/model/request/register_request/register_request.dart';
import 'package:project_movie_app/features_tmp/network/model/response/login_response/login_response.dart';
import 'package:project_movie_app/features_tmp/network/model/response/register_response/register_response.dart';

abstract class AuthRemoteDataSource {
  Future<ApiResult<LoginResponse>> login(LoginRequest request);
  Future<ApiResult<RegisterResponse>> register(RegisterRequest request);
}
