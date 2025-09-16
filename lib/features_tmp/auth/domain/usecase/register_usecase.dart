import 'package:injectable/injectable.dart';
import 'package:project_movie_app/features_tmp/auth/domain/repositories/auth_repository.dart';
import 'package:project_movie_app/features_tmp/network/model/request/register_request/register_request.dart';
import 'package:project_movie_app/features_tmp/network/model/response/token_response/token_response.dart';

import '../../../../core/api_result/api_result.dart';

@injectable
class RegisterUseCase {
  final AuthRepository _repository;

  RegisterUseCase(this._repository);

  Future<ApiResult<TokenResponse>> call(RegisterRequest request) {
    return _repository.register(request);
  }
}
