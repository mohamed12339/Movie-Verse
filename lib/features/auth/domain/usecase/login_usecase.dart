import 'package:injectable/injectable.dart';
import 'package:project_movie_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:project_movie_app/features/network/model/request/login_request/login_request.dart';

import '../../../../core/api_result/api_result.dart';

@injectable
class LoginUseCase {
  final AuthRepository _authRepository;

  LoginUseCase(this._authRepository);

  Future<ApiResult<void>> call(LoginRequest request) {
    return _authRepository.login(request);
  }
}
