import 'package:injectable/injectable.dart';
import 'package:project_movie_app/features_tmp/auth/domain/repositories/auth_repository.dart';
import 'package:project_movie_app/features_tmp/network/model/request/login_request/login_request.dart';
import 'package:project_movie_app/features_tmp/network/model/response/token_response/token_response.dart';

import '../../../../core/api_result/api_result.dart';

@injectable
class LoginUseCase {
  final AuthRepository _authRepository;

  LoginUseCase(this._authRepository);

  Future<ApiResult<TokenResponse>> call(LoginRequest request) {
    return _authRepository.login(request);
  }
}
