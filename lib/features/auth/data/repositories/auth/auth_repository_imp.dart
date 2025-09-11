import 'package:injectable/injectable.dart';
import 'package:project_movie_app/core/api_result/api_result.dart';
import 'package:project_movie_app/core/utility/app_preferences/token_storage.dart';
import 'package:project_movie_app/features/auth/data/repositories/auth/data_sources/auth_remote_data_source.dart';
import 'package:project_movie_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:project_movie_app/features/network/model/request/login_request/login_request.dart';
import 'package:project_movie_app/features/network/model/request/register_request/register_request.dart';
import 'package:project_movie_app/features/network/model/response/login_response/login_response.dart';
import 'package:project_movie_app/features/network/model/response/register_response/register_response.dart';

@Injectable(as: AuthRepository)
class AuthRepositoryImp extends AuthRepository {
  final AuthRemoteDataSource _remoteDataSource;
  AuthRepositoryImp(this._remoteDataSource);

  @override
  Future<ApiResult<void>> login(LoginRequest request) async {
    ApiResult<LoginResponse> apiResult = await _remoteDataSource.login(request);

    if (apiResult is SuccessApiResult) {
      final token = apiResult.myData.data;
      if (token.isNotEmpty) {
        await TokenStorage.saveToken(token);
      }
      return SuccessApiResult(null);
    } else {
      return ErrorApiResult(apiResult.myError);
    }
  }

  @override
  Future<ApiResult<void>> register(RegisterRequest request) async {
    ApiResult<RegisterResponse> apiResult = await _remoteDataSource.register(
      request,
    );

    if (apiResult is SuccessApiResult) {
      final loginResult = await _remoteDataSource.login(
        LoginRequest(email: request.email, password: request.password),
      );
      if (loginResult is SuccessApiResult) {
        final token = loginResult.myData.data;
        if (token.isNotEmpty) {
          await TokenStorage.saveToken(token);
        }
        return SuccessApiResult(null);
      } else {
        return ErrorApiResult(loginResult.myError);
      }
    } else {
      return ErrorApiResult(apiResult.myError);
    }
  }
}
