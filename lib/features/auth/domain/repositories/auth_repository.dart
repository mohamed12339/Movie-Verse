import 'package:project_movie_app/core/api_result/api_result.dart';
import 'package:project_movie_app/features/network/model/request/register_request/register_request.dart';

import '../../../network/model/request/login_request/login_request.dart';

abstract class AuthRepository {
  Future<ApiResult<void>> login(LoginRequest request);
  Future<ApiResult<void>> register(RegisterRequest request);
}
