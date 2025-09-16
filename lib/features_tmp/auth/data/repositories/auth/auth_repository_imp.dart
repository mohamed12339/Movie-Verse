import 'package:injectable/injectable.dart';
import 'package:project_movie_app/core/api_result/api_result.dart';
import 'package:project_movie_app/core/utility/app_preferences/token_storage.dart';
import 'package:project_movie_app/core/utility/app_preferences/user_storage.dart';
import 'package:project_movie_app/features_tmp/auth/data/google_services/google_sign_in_service.dart';
import 'package:project_movie_app/features_tmp/auth/data/repositories/auth/data_sources/auth_remote_data_source.dart';
import 'package:project_movie_app/features_tmp/auth/domain/repositories/auth_repository.dart';
import 'package:project_movie_app/features_tmp/network/model/request/login_request/login_request.dart';
import 'package:project_movie_app/features_tmp/network/model/request/register_request/register_request.dart';
import 'package:project_movie_app/features_tmp/network/model/response/login_response/login_response.dart';
import 'package:project_movie_app/features_tmp/network/model/response/register_response/register_response.dart';
import 'package:project_movie_app/features_tmp/network/model/response/token_response/token_response.dart';

@Injectable(as: AuthRepository)
class AuthRepositoryImp extends AuthRepository {
  final AuthRemoteDataSource _remoteDataSource;
  final GoogleSignInService _google;
  AuthRepositoryImp(this._remoteDataSource, this._google);

  @override
  Future<ApiResult<TokenResponse>> login(LoginRequest request) async {
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
  Future<ApiResult<TokenResponse>> register(RegisterRequest request) async {
    ApiResult<RegisterResponse> apiResult =
    await _remoteDataSource.register(request);

    if (apiResult is SuccessApiResult) {
      /// بعد ما نسجل، نعمل login تلقائي
      final loginResult = await _remoteDataSource.login(
        LoginRequest(email: request.email, password: request.password),
      );

      if (loginResult is SuccessApiResult) {
        final token = loginResult.myData.data;

        if (token.isNotEmpty) {
          ///  خزّن التوكن
          await TokenStorage.saveToken(token);

          /// خزّن بيانات اليوزر (اللي عندي من register request)
          await UserStorage.saveUser(
            name: request.name,
            email: request.email,
            avatarId: request.avaterId, // ده int required في RegisterRequest
          );
        }

        return SuccessApiResult(null);
      } else {
        return ErrorApiResult(loginResult.myError);
      }
    } else {
      return ErrorApiResult(apiResult.myError);
    }
  }

  @override
  Future<ApiResult<void>> signInWithGoogle() async {
    try {
      final idToken = await _google.signInAndGetIdToken();
      if (idToken == null || idToken.isEmpty) {
        return ErrorApiResult(UnKnownError('CANCELED_OR_FAILED'));
      }
      await TokenStorage.saveToken(idToken);
      return SuccessApiResult(null);
    } catch (e) {
      return ErrorApiResult(UnKnownError(e.toString()));
    }
  }

  @override
  Future<void> signOut() async {
    await _google.signOut();
    await TokenStorage.clearToken();
  }
}
