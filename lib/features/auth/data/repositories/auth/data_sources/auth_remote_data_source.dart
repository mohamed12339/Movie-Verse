import 'package:project_movie_app/core/api_result/api_result.dart';
import 'package:project_movie_app/features/network/model/request/login_request/login_request.dart';
import 'package:project_movie_app/features/network/model/request/register_request/register_request.dart';
import 'package:project_movie_app/features/network/model/response/token_response/token_response.dart';

abstract class AuthRemoteDataSource {
  Future<ApiResult<TokenResponse>> login(LoginRequest request);
  Future<ApiResult<TokenResponse>> register(RegisterRequest request);
}
